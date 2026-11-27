require "test_helper"

class Staff::ReportControllerTest < ActionDispatch::IntegrationTest
  test "should redirect index to login when not logged in" do
    get staff_reports_url
    assert_redirected_to login_url
  end

  test "should redirect show to login when not logged in" do
    get staff_report_url(reports(:one))
    assert_redirected_to login_url
  end

  test "should redirect index to login when logged in as citizen" do
    log_in_as(users(:one))
    get staff_reports_url
    assert_redirected_to login_url
  end

  test "should get index when logged in as staff" do
    log_in_as(users(:two))
    get staff_reports_url
    assert_response :success
  end

  test "should get show when logged in as staff" do
    log_in_as(users(:two))
    get staff_report_url(reports(:one))
    assert_response :success
  end

  test "staff should change tags" do
    log_in_as(users(:two))
    patch staff_report_url(reports(:one)), params: {
      tag_choices: { pattern: tags(:chatora).id, condition: [ "", tags(:injured).id ] }
    }

    assert_redirected_to staff_report_url(reports(:one))
    assert_equal [ tags(:chatora), tags(:injured) ].sort, reports(:one).reload.tags.sort
  end

  test "staff should remove all condition tags" do
    reports(:one).report_tags.create!(tag: tags(:injured), source: "citizen")

    log_in_as(users(:two))
    patch staff_report_url(reports(:one)), params: {
      tag_choices: { pattern: tags(:kijitora).id, condition: [ "" ] }
    }

    assert_equal [ tags(:kijitora) ], reports(:one).reload.tags
  end

  test "staff should change single choice tag sent as array" do
    log_in_as(users(:two))
    patch staff_report_url(reports(:one)), params: { tag_choices: { pattern: [ tags(:chatora).id ] } }

    assert_redirected_to staff_report_url(reports(:one))
    assert_equal [ tags(:chatora) ], reports(:one).reload.tags
  end

  test "staff should not set two tags in single choice category" do
    log_in_as(users(:two))
    patch staff_report_url(reports(:one)), params: {
      tag_choices: { pattern: [ tags(:kijitora).id, tags(:chatora).id ] }
    }

    assert_response :unprocessable_content
    assert_equal [ tags(:kijitora) ], reports(:one).reload.tags
  end

  test "staff should remove all tags with empty tag choices" do
    log_in_as(users(:two))
    patch staff_report_url(reports(:one)), params: { tag_choices: "" }

    assert_redirected_to staff_report_url(reports(:one))
    assert_empty reports(:one).reload.tags
  end

  test "citizen should not change tags" do
    log_in_as(users(:one))
    patch staff_report_url(reports(:one)), params: { tag_choices: { pattern: tags(:chatora).id } }

    assert_redirected_to login_url
    assert_equal [ tags(:kijitora) ], reports(:one).reload.tags
  end
end