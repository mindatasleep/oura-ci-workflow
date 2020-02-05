require "application_system_test_case"

class OurasTest < ApplicationSystemTestCase
  setup do
    @oura = ouras(:one)
  end

  test "visiting the index" do
    visit ouras_url
    assert_selector "h1", text: "Ouras"
  end

  test "creating a Oura" do
    visit ouras_url
    click_on "New Oura"

    fill_in "Activity", with: @oura.activity
    fill_in "Readiness", with: @oura.readiness
    fill_in "Sleep", with: @oura.sleep
    fill_in "User", with: @oura.user_id
    fill_in "Userinfo", with: @oura.userinfo
    click_on "Create Oura"

    assert_text "Oura was successfully created"
    click_on "Back"
  end

  test "updating a Oura" do
    visit ouras_url
    click_on "Edit", match: :first

    fill_in "Activity", with: @oura.activity
    fill_in "Readiness", with: @oura.readiness
    fill_in "Sleep", with: @oura.sleep
    fill_in "User", with: @oura.user_id
    fill_in "Userinfo", with: @oura.userinfo
    click_on "Update Oura"

    assert_text "Oura was successfully updated"
    click_on "Back"
  end

  test "destroying a Oura" do
    visit ouras_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Oura was successfully destroyed"
  end
end
