require "test_helper"

class Staff::TownControllerTest < ActionDispatch::IntegrationTest
  test "should redirect index to login when not logged in" do
    get staff_towns_url
    assert_redirected_to login_url
  end

  test "should redirect show to login when not logged in" do
    get staff_town_url(towns(:one))
    assert_redirected_to login_url
  end

  test "should redirect index to login when logged in as citizen" do
    log_in_as(users(:one))
    get staff_towns_url
    assert_redirected_to login_url
  end

  test "should get index when logged in as staff" do
    log_in_as(users(:two))
    get staff_towns_url
    assert_response :success
  end

  test "should get show when logged in as staff" do
    log_in_as(users(:two))
    get staff_town_url(towns(:one))
    assert_response :success
  end
end
