require "test_helper"

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get profiles_show_url
    assert_response :success
  end

  test "should get home" do
    get profiles_home_url
    assert_response :success
  end
end
