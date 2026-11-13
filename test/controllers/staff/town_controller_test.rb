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
end
