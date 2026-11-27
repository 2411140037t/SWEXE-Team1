class Report < ApplicationRecord
  belongs_to :user
  belongs_to :town

  has_one_attached :photo

  has_many :report_tags, dependent: :destroy, autosave: true
  has_many :tags, through: :report_tags

  enum :ear_tip, { left: "left", right: "right", both: "both", none: "none", unknown: "unknown" }, default: "unknown", prefix: true
  enum :status, { pending: "pending", approved: "approved", rejected: "rejected" }, default: "pending"

  validate :one_tag_per_single_choice_category

  # 選ばれたタグに付け替える。保存は save のときにまとめて行う
  # - 外されたタグは削除予約
  # - 新しく選ばれたタグは source 付きで追加
  # - そのまま残ったタグは、最初に付けた人の source を保つ
  def select_tags(tag_ids, source:)
    selected_ids = Tag.where(id: Array(tag_ids).compact_blank).pluck(:id)

    report_tags.each do |report_tag|
      report_tag.mark_for_destruction unless selected_ids.include?(report_tag.tag_id)
    end

    (selected_ids - report_tags.map(&:tag_id)).each do |tag_id|
      report_tags.build(tag_id: tag_id, source: source)
    end
  end

  # 削除予約されたものを除いた、現在のタグ
  def current_tags
    report_tags.reject(&:marked_for_destruction?).map(&:tag)
  end

  # { "柄" => [茶トラ], "様子" => [怪我あり, やせている] } の形で返す（詳細画面の表示用）
  def tags_by_category
    current_tags.sort_by { |tag| [ Tag::CATEGORY_LABELS.keys.index(tag.category), tag.position ] }
                .group_by(&:category_label)
  end

  private

  def one_tag_per_single_choice_category
    current_tags.select(&:single_choice?).group_by(&:category).each do |category, tags|
      next if tags.size <= 1

      errors.add(:tags, "の「#{Tag::CATEGORY_LABELS[category]}」は1つだけ選んでください")
    end
  end
end
