require "test_helper"

class Staff::ReportControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get staff_reports_url
    assert_response :success
  end

  test "should get show" do
    get staff_report_url(reports(:one))
    assert_response :success
  end
end
