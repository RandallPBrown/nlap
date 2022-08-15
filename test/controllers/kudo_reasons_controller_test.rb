require 'test_helper'

class KudoReasonsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @kudo_reason = kudo_reasons(:one)
  end

  test "should get index" do
    get kudo_reasons_url
    assert_response :success
  end

  test "should get new" do
    get new_kudo_reason_url
    assert_response :success
  end

  test "should create kudo_reason" do
    assert_difference('KudoReason.count') do
      post kudo_reasons_url, params: { kudo_reason: { description: @kudo_reason.description } }
    end

    assert_redirected_to kudo_reason_url(KudoReason.last)
  end

  test "should show kudo_reason" do
    get kudo_reason_url(@kudo_reason)
    assert_response :success
  end

  test "should get edit" do
    get edit_kudo_reason_url(@kudo_reason)
    assert_response :success
  end

  test "should update kudo_reason" do
    patch kudo_reason_url(@kudo_reason), params: { kudo_reason: { description: @kudo_reason.description } }
    assert_redirected_to kudo_reason_url(@kudo_reason)
  end

  test "should destroy kudo_reason" do
    assert_difference('KudoReason.count', -1) do
      delete kudo_reason_url(@kudo_reason)
    end

    assert_redirected_to kudo_reasons_url
  end
end
