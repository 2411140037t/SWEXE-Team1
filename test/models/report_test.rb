require "test_helper"

class ReportTest < ActiveSupport::TestCase
  setup do
    @report = reports(:one) # fixtures でキジトラ（citizen）が付いている
  end

  test "select_tags replaces tags on save" do
    @report.select_tags([ tags(:chatora).id, tags(:kitten).id ], source: "citizen")
    assert @report.save

    assert_equal [ tags(:chatora), tags(:kitten) ].sort, @report.reload.tags.sort
  end

  test "can choose multiple tags in condition" do
    @report.select_tags([ tags(:injured).id, tags(:thin).id ], source: "citizen")
    assert @report.save
    assert_equal 2, @report.reload.tags.count
  end

  test "cannot choose two tags in a single choice category" do
    @report.select_tags([ tags(:kijitora).id, tags(:chatora).id ], source: "citizen")

    assert_not @report.save
    assert_includes @report.errors.full_messages_for(:tags).join, "柄"
    assert_equal [ tags(:kijitora) ], @report.reload.tags, "保存に失敗したらタグは変わらない"
  end

  test "staff edit keeps citizen source for kept tags and marks new ones as staff" do
    @report.select_tags([ tags(:kijitora).id, tags(:injured).id ], source: "staff")
    assert @report.save

    sources = @report.reload.report_tags.to_h { |report_tag| [ report_tag.tag, report_tag.source ] }
    assert_equal "citizen", sources[tags(:kijitora)]
    assert_equal "staff", sources[tags(:injured)]
  end

  test "unknown tag ids and blanks are ignored" do
    @report.select_tags([ "", "999999", tags(:kitten).id ], source: "citizen")
    assert @report.save
    assert_equal [ tags(:kitten) ], @report.reload.tags
  end

  test "tags_by_category groups tags by category label" do
    @report.select_tags([ tags(:chatora).id, tags(:thin).id, tags(:injured).id ], source: "citizen")
    @report.save!

    grouped = @report.reload.tags_by_category
    assert_equal [ "柄", "様子" ], grouped.keys
    assert_equal [ tags(:injured), tags(:thin) ], grouped["様子"]
  end
end