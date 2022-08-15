require 'test_helper'

class ShortkeysControllerTest < ActionDispatch::IntegrationTest
  setup do
    @shortkey = shortkeys(:one)
  end

  test "should get index" do
    get shortkeys_url
    assert_response :success
  end

  test "should get new" do
    get new_shortkey_url
    assert_response :success
  end

  test "should create shortkey" do
    assert_difference('Shortkey.count') do
      post shortkeys_url, params: { shortkey: { body: @shortkey.body, created_by: @shortkey.created_by, department_id: @shortkey.department_id, name: @shortkey.name } }
    end

    assert_redirected_to shortkey_url(Shortkey.last)
  end

  test "should show shortkey" do
    get shortkey_url(@shortkey)
    assert_response :success
  end

  test "should get edit" do
    get edit_shortkey_url(@shortkey)
    assert_response :success
  end

  test "should update shortkey" do
    patch shortkey_url(@shortkey), params: { shortkey: { body: @shortkey.body, created_by: @shortkey.created_by, department_id: @shortkey.department_id, name: @shortkey.name } }
    assert_redirected_to shortkey_url(@shortkey)
  end

  test "should destroy shortkey" do
    assert_difference('Shortkey.count', -1) do
      delete shortkey_url(@shortkey)
    end

    assert_redirected_to shortkeys_url
  end
end
