require "application_system_test_case"

class SecretSantaTest < ApplicationSystemTestCase
  setup do
    @secret_santa = secret_santa(:one)
  end

  test "visiting the index" do
    visit secret_santa_url
    assert_selector "h1", text: "Secret santa"
  end

  test "should create secret santum" do
    visit secret_santa_url
    click_on "New secret santum"

    fill_in "Code", with: @secret_santa.code
    fill_in "Description", with: @secret_santa.description
    fill_in "Name", with: @secret_santa.name
    click_on "Create Secret santum"

    assert_text "Secret santum was successfully created"
    click_on "Back"
  end

  test "should update Secret santum" do
    visit secret_santa_url(@secret_santa)
    click_on "Edit this secret santum", match: :first

    fill_in "Code", with: @secret_santa.code
    fill_in "Description", with: @secret_santa.description
    fill_in "Name", with: @secret_santa.name
    click_on "Update Secret santum"

    assert_text "Secret santum was successfully updated"
    click_on "Back"
  end

  test "should destroy Secret santum" do
    visit secret_santa_url(@secret_santa)
    click_on "Destroy this secret santum", match: :first

    assert_text "Secret santum was successfully destroyed"
  end
end
