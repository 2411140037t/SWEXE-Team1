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
    return [] unless tag_choices_submitted?

    permitted = Tag::CATEGORY_LABELS.keys.map do |category|
      Tag.single_choice?(category) ? category.to_sym : { category.to_sym => [] }
    end
    params.require(:tag_choices).permit(*permitted).to_h.values.flatten.compact_blank
  end
end