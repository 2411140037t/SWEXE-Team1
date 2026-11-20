require "test_helper"

class ReportControllerTest < ActionDispatch::IntegrationTest
  setup do
    @citizen = users(:one)
  end

  test "should redirect index to login when not logged in" do
    get reports_url
    assert_redirected_to login_url
  end

  test "should redirect new to login when not logged in" do
    get new_report_url
    assert_redirected_to login_url
  end

  test "should get index" do
    log_in_as(@citizen)
    get reports_url
    assert_response :success
  end

  test "should get new" do
    log_in_as(@citizen)
    get new_report_url
    assert_response :success
  end

  test "should post create" do
    log_in_as(@citizen)
    post reports_url
    assert_response :success
  end

  test "should get show" do
    log_in_as(@citizen)
    get report_url(reports(:one))
    assert_response :success
  end
end
