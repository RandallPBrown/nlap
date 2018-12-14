require 'test_helper'

class DapsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dap = daps(:one)
  end

  test "should get index" do
    get daps_url
    assert_response :success
  end

  test "should get new" do
    get new_dap_url
    assert_response :success
  end

  test "should create dap" do
    assert_difference('Dap.count') do
      post daps_url, params: { dap: { ddate: @dap.ddate, description: @dap.description, user_id: @dap.user_id, writeup_id: @dap.writeup_id } }
    end

    assert_redirected_to dap_url(Dap.last)
  end

  test "should show dap" do
    get dap_url(@dap)
    assert_response :success
  end

  test "should get edit" do
    get edit_dap_url(@dap)
    assert_response :success
  end

  test "should update dap" do
    patch dap_url(@dap), params: { dap: { ddate: @dap.ddate, description: @dap.description, user_id: @dap.user_id, writeup_id: @dap.writeup_id } }
    assert_redirected_to dap_url(@dap)
  end

  test "should destroy dap" do
    assert_difference('Dap.count', -1) do
      delete dap_url(@dap)
    end

    assert_redirected_to daps_url
  end
end
