require "test_helper"

class SecretSantaControllerTest < ActionDispatch::IntegrationTest
  setup do
    @secret_santa = secret_santa(:one)
  end

  test "should get index" do
    get secret_santa_url
    assert_response :success
  end

  test "should get new" do
    get new_secret_santa_url
    assert_response :success
  end

  test "should create secret_santa" do
    assert_difference("SecretSantum.count") do
      post secret_santa_url, params: { secret_santa: { code: @secret_santa.code, description: @secret_santa.description, name: @secret_santa.name } }
    end

    assert_redirected_to secret_santa_url(SecretSantum.last)
  end

  test "should show secret_santa" do
    get secret_santa_url(@secret_santa)
    assert_response :success
  end

  test "should get edit" do
    get edit_secret_santa_url(@secret_santa)
    assert_response :success
  end

  test "should update secret_santa" do
    patch secret_santa_url(@secret_santa), params: { secret_santa: { code: @secret_santa.code, description: @secret_santa.description, name: @secret_santa.name } }
    assert_redirected_to secret_santa_url(@secret_santa)
  end

  test "should destroy secret_santa" do
    assert_difference("SecretSantum.count", -1) do
      delete secret_santa_url(@secret_santa)
    end

    assert_redirected_to secret_santa_url
  end
end
