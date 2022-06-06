require "test_helper"

class MovieSeensControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get movie_seens_index_url
    assert_response :success
  end
end
