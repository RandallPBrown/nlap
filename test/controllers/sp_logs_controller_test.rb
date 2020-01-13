require 'test_helper'

class SpLogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sp_log = sp_logs(:one)
  end

  test "should get index" do
    get sp_logs_url
    assert_response :success
  end

  test "should get new" do
    get new_sp_log_url
    assert_response :success
  end

  test "should create sp_log" do
    assert_difference('SpLog.count') do
      post sp_logs_url, params: { sp_log: { email: @sp_log.email, name: @sp_log.name, notes: @sp_log.notes, phone: @sp_log.phone, sp_log_type_id: @sp_log.sp_log_type_id, state: @sp_log.state } }
    end

    assert_redirected_to sp_log_url(SpLog.last)
  end

  test "should show sp_log" do
    get sp_log_url(@sp_log)
    assert_response :success
  end

  test "should get edit" do
    get edit_sp_log_url(@sp_log)
    assert_response :success
  end

  test "should update sp_log" do
    patch sp_log_url(@sp_log), params: { sp_log: { email: @sp_log.email, name: @sp_log.name, notes: @sp_log.notes, phone: @sp_log.phone, sp_log_type_id: @sp_log.sp_log_type_id, state: @sp_log.state } }
    assert_redirected_to sp_log_url(@sp_log)
  end

  test "should destroy sp_log" do
    assert_difference('SpLog.count', -1) do
      delete sp_log_url(@sp_log)
    end

    assert_redirected_to sp_logs_url
  end
end
