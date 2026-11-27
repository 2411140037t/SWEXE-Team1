require "test_helper"

class TagTest < ActiveSupport::TestCase
  test "same name in same category is invalid" do
    tag = Tag.new(category: "pattern", name: "キジトラ")
    assert_not tag.valid?
  end

  test "same name in different category is valid" do
    tag = Tag.new(category: "age", name: "キジトラ")
    assert tag.valid?
  end

  test "color must be hex like #RRGGBB" do
    assert_not Tag.new(category: "pattern", name: "新しい柄", color: "red").valid?
    assert Tag.new(category: "pattern", name: "新しい柄", color: "#FF0000").valid?
  end

  test "chips_by_category returns active tags in category order" do
    chips = Tag.chips_by_category

    assert_equal Tag::CATEGORY_LABELS.keys, chips.keys
    assert_equal [ tags(:kijitora), tags(:chatora) ], chips["pattern"]
    assert_not_includes chips["pattern"], tags(:hidden)
  end

  test "condition is the only multiple choice category" do
    assert tags(:kijitora).single_choice?
    assert tags(:kitten).single_choice?
    assert_not tags(:injured).single_choice?
  end
end