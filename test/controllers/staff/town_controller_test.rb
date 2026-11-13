require "test_helper"

class Staff::TownControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get staff_towns_url
    assert_response :success
  end

  test "should get show" do
    get staff_town_url(towns(:one))
    assert_response :success
  end
end
