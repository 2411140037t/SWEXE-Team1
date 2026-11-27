class Tag < ApplicationRecord
  # カテゴリの表示名（この順番でフォームに並ぶ）
  CATEGORY_LABELS = {
    "pattern" => "柄",
    "coat_length" => "毛の長さ",
    "age" => "年齢",
    "collar" => "首輪",
    "condition" => "様子"
  }.freeze

  # 1つだけ選べるカテゴリ（様子 以外）
  SINGLE_CHOICE_CATEGORIES = %w[pattern coat_length age collar].freeze

  enum :category, CATEGORY_LABELS.keys.index_with(&:itself), prefix: true

  has_many :report_tags, dependent: :restrict_with_error
  has_many :reports, through: :report_tags

  validates :name, presence: true, uniqueness: { scope: :category }
  validates :color, format: { with: /\A#\h{6}\z/ }, allow_blank: true

  scope :active, -> { where(active: true) }
  scope :ordered, -> { order(:position, :id) }

  # { "pattern" => [キジトラ, 茶トラ, ...], "coat_length" => [...], ... }
  def self.chips_by_category
    tags = active.ordered.to_a
    CATEGORY_LABELS.keys.index_with { |category| tags.select { |tag| tag.category == category } }
  end

  def self.single_choice?(category)
    SINGLE_CHOICE_CATEGORIES.include?(category.to_s)
  end

  def category_label
    CATEGORY_LABELS.fetch(category)
  end

  def single_choice?
    self.class.single_choice?(category)
  end
end
