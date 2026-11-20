require "test_helper"

class RankingControllerTest < ActionDispatch::IntegrationTest
  test "should redirect index to login when not logged in" do
    get ranking_index_url
    assert_redirected_to login_url
  end

  test "should get index" do
    log_in_as(users(:one))
    get ranking_index_url
    assert_response :success
  end
end
