require 'test_helper'

class TileControllerTest < ActionDispatch::IntegrationTest
  test "should get view" do
    get tile_view_url
    assert_response :success
  end

end
