require "test_helper"

class ReportControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get reports_url
    assert_response :success
  end

  test "should get new" do
    get new_report_url
    assert_response :success
  end

  test "should post create" do
    post reports_url
    assert_response :success
  end

  test "should get show" do
    get report_url(reports(:one))
    assert_response :success
  end
end
