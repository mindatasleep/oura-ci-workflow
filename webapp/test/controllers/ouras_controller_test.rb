require 'test_helper'

class OurasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @oura = ouras(:one)
  end

  test "should get index" do
    get ouras_url
    assert_response :success
  end

  test "should get new" do
    get new_oura_url
    assert_response :success
  end

  test "should create oura" do
    assert_difference('Oura.count') do
      post ouras_url, params: { oura: { activity: @oura.activity, readiness: @oura.readiness, sleep: @oura.sleep, user_id: @oura.user_id, userinfo: @oura.userinfo } }
    end

    assert_redirected_to oura_url(Oura.last)
  end

  test "should show oura" do
    get oura_url(@oura)
    assert_response :success
  end

  test "should get edit" do
    get edit_oura_url(@oura)
    assert_response :success
  end

  test "should update oura" do
    patch oura_url(@oura), params: { oura: { activity: @oura.activity, readiness: @oura.readiness, sleep: @oura.sleep, user_id: @oura.user_id, userinfo: @oura.userinfo } }
    assert_redirected_to oura_url(@oura)
  end

  test "should destroy oura" do
    assert_difference('Oura.count', -1) do
      delete oura_url(@oura)
    end

    assert_redirected_to ouras_url
  end
end
