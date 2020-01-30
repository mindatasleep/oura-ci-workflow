require 'test_helper'

class OuraControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get oura_index_url
    assert_response :success
  end

  test "should get login" do
    get oura_login_url
    assert_response :success
  end

  test "should get user" do
    get oura_user_url
    assert_response :success
  end

end
