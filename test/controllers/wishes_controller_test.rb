require "test_helper"

class WishesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get wishes_index_url
    assert_response :success
  end
end
