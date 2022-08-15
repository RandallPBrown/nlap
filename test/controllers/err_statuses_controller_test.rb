require 'test_helper'

class ErrStatusesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @err_status = err_statuses(:one)
  end

  test "should get index" do
    get err_statuses_url
    assert_response :success
  end

  test "should get new" do
    get new_err_status_url
    assert_response :success
  end

  test "should create err_status" do
    assert_difference('ErrStatus.count') do
      post err_statuses_url, params: { err_status: { errvalue: @err_status.errvalue, statusname: @err_status.statusname } }
    end

    assert_redirected_to err_status_url(ErrStatus.last)
  end

  test "should show err_status" do
    get err_status_url(@err_status)
    assert_response :success
  end

  test "should get edit" do
    get edit_err_status_url(@err_status)
    assert_response :success
  end

  test "should update err_status" do
    patch err_status_url(@err_status), params: { err_status: { errvalue: @err_status.errvalue, statusname: @err_status.statusname } }
    assert_redirected_to err_status_url(@err_status)
  end

  test "should destroy err_status" do
    assert_difference('ErrStatus.count', -1) do
      delete err_status_url(@err_status)
    end

    assert_redirected_to err_statuses_url
  end
end
