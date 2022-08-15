require 'test_helper'

class ErrLogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @err_log = err_logs(:one)
  end

  test "should get index" do
    get err_logs_url
    assert_response :success
  end

  test "should get new" do
    get new_err_log_url
    assert_response :success
  end

  test "should create err_log" do
    assert_difference('ErrLog.count') do
      post err_logs_url, params: { err_log: { department_id: @err_log.department_id, err_name_id: @err_log.err_name_id, err_status_id: @err_log.err_status_id, errdate: @err_log.errdate, errdesc: @err_log.errdesc, errsubmitby: @err_log.errsubmitby, user_id: @err_log.user_id } }
    end

    assert_redirected_to err_log_url(ErrLog.last)
  end

  test "should show err_log" do
    get err_log_url(@err_log)
    assert_response :success
  end

  test "should get edit" do
    get edit_err_log_url(@err_log)
    assert_response :success
  end

  test "should update err_log" do
    patch err_log_url(@err_log), params: { err_log: { department_id: @err_log.department_id, err_name_id: @err_log.err_name_id, err_status_id: @err_log.err_status_id, errdate: @err_log.errdate, errdesc: @err_log.errdesc, errsubmitby: @err_log.errsubmitby, user_id: @err_log.user_id } }
    assert_redirected_to err_log_url(@err_log)
  end

  test "should destroy err_log" do
    assert_difference('ErrLog.count', -1) do
      delete err_log_url(@err_log)
    end

    assert_redirected_to err_logs_url
  end
end
