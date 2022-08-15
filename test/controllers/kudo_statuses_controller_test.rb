require 'test_helper'

class KudoStatusesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @kudo_status = kudo_statuses(:one)
  end

  test "should get index" do
    get kudo_statuses_url
    assert_response :success
  end

  test "should get new" do
    get new_kudo_status_url
    assert_response :success
  end

  test "should create kudo_status" do
    assert_difference('KudoStatus.count') do
      post kudo_statuses_url, params: { kudo_status: { description: @kudo_status.description } }
    end

    assert_redirected_to kudo_status_url(KudoStatus.last)
  end

  test "should show kudo_status" do
    get kudo_status_url(@kudo_status)
    assert_response :success
  end

  test "should get edit" do
    get edit_kudo_status_url(@kudo_status)
    assert_response :success
  end

  test "should update kudo_status" do
    patch kudo_status_url(@kudo_status), params: { kudo_status: { description: @kudo_status.description } }
    assert_redirected_to kudo_status_url(@kudo_status)
  end

  test "should destroy kudo_status" do
    assert_difference('KudoStatus.count', -1) do
      delete kudo_status_url(@kudo_status)
    end

    assert_redirected_to kudo_statuses_url
  end
end
