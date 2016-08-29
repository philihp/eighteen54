require 'test_helper'

class CompanyControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get company_index_url
    assert_response :success
  end

  test "should get show" do
    get company_show_url
    assert_response :success
  end

  test "should get bid" do
    get company_bid_url
    assert_response :success
  end

end
