require 'test_helper'

class InstanceControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get instance_create_url
    assert_response :success
  end

  test "should get show" do
    get instance_show_url
    assert_response :success
  end

end
