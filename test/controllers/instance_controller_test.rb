require 'test_helper'

class InstanceControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get instance_show_url
    assert_response :success
  end

end
