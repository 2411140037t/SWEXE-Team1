require "test_helper"

class AppControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get app_index_url
    assert_response :success
  end

  test "logged in citizen should be redirected from top to reports" do
    log_in_as(users(:one))
    get root_url
    assert_redirected_to reports_url
  end

  test "logged in staff should be redirected from top to staff reports" do
    log_in_as(users(:two))
    get root_url
    assert_redirected_to staff_reports_url
  end
end
