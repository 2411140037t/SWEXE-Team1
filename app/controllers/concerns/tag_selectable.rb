# フォームから送られてきたタグの選択を、タグIDの配列にする
#   tag_choices[pattern]=3, tag_choices[condition][]=12, tag_choices[condition][]=13
#   → [3, 12, 13]
module TagSelectable
  extend ActiveSupport::Concern

  private

  def tag_choices_submitted?
    params.key?(:tag_choices)
  end

  def selected_tag_ids
    choices = params[:tag_choices]
    return [] unless choices.is_a?(ActionController::Parameters)

    categories = Tag::CATEGORY_LABELS.keys.map(&:to_sym)
    choices.permit(*categories, categories.index_with { [] }).to_h.values.flatten.compact_blank
  end
end