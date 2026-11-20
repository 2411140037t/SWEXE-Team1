require "test_helper"

class UserControllerTest < ActionDispatch::IntegrationTest
  def valid_params(overrides = {})
    {
      user: {
        name: "New User",
        nickname: "newbie",
        email: "new@example.com",
        password: "password",
        password_confirmation: "password"
      }.merge(overrides)
    }
  end

  test "should get new" do
    get signup_url
    assert_response :success
  end

  test "should sign up and log in" do
    assert_difference("User.count", 1) do
      post signup_url, params: valid_params
    end
    user = User.find_by(email: "new@example.com")
    assert_redirected_to reports_url
    assert_equal user.id, session[:user_id]
  end

  test "new user should be citizen even if role is sent" do
    post signup_url, params: valid_params(role: "staff")
    assert User.find_by(email: "new@example.com").citizen?
  end

  test "should not sign up when password confirmation does not match" do
    assert_no_difference("User.count") do
      post signup_url, params: valid_params(password_confirmation: "different")
    end
    assert_response :unprocessable_content
    assert_nil session[:user_id]
  end

  test "should not sign up with duplicate email" do
    assert_no_difference("User.count") do
      post signup_url, params: valid_params(email: users(:one).email)
    end
    assert_response :unprocessable_content
  end
end

class UserControllerLoggedInTest < ActionDispatch::IntegrationTest
  test "logged in user should be redirected from signup to reports" do
    log_in_as(users(:one))
    get signup_url
    assert_redirected_to reports_url
  end
end
