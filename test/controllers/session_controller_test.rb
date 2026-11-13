require "test_helper"

class SessionControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get login_url
    assert_response :success
  end

  test "should post create" do
    post login_url
    assert_response :success
  end

  test "should delete destroy" do
    delete logout_url
    assert_response :success
  end
end
