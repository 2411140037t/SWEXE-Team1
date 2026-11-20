require "test_helper"

class SessionControllerTest < ActionDispatch::IntegrationTest
  setup do
    @citizen = users(:one)
    @staff = users(:two)
  end

  test "should get new" do
    get login_url
    assert_response :success
  end

  test "citizen should log in and be redirected to reports" do
    post login_url, params: { email: @citizen.email, password: "password" }
    assert_redirected_to reports_url
    assert_equal @citizen.id, session[:user_id]
  end

  test "staff should log in and be redirected to staff reports" do
    post login_url, params: { email: @staff.email, password: "password" }
    assert_redirected_to staff_reports_url
    assert_equal @staff.id, session[:user_id]
  end

  test "should log in with upper case email" do
    post login_url, params: { email: @citizen.email.upcase, password: "password" }
    assert_redirected_to reports_url
  end

  test "should not log in with wrong password" do
    post login_url, params: { email: @citizen.email, password: "wrong" }
    assert_response :unprocessable_content
    assert_nil session[:user_id]
  end

  test "should not log in with unknown email" do
    post login_url, params: { email: "nobody@example.com", password: "password" }
    assert_response :unprocessable_content
    assert_nil session[:user_id]
  end

  test "should log out" do
    log_in_as(@citizen)
    delete logout_url
    assert_redirected_to login_url
    assert_response :see_other
    assert_nil session[:user_id]
  end
end

class SessionControllerLoggedInTest < ActionDispatch::IntegrationTest
  test "logged in citizen should be redirected from login to reports" do
    log_in_as(users(:one))
    get login_url
    assert_redirected_to reports_url
  end

  test "logged in staff should be redirected from login to staff reports" do
    log_in_as(users(:two))
    get login_url
    assert_redirected_to staff_reports_url
  end
end
