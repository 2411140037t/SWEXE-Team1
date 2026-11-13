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
end
