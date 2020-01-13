require 'test_helper'

class SpLogTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sp_log_type = sp_log_types(:one)
  end

  test "should get index" do
    get sp_log_types_url
    assert_response :success
  end

  test "should get new" do
    get new_sp_log_type_url
    assert_response :success
  end

  test "should create sp_log_type" do
    assert_difference('SpLogType.count') do
      post sp_log_types_url, params: { sp_log_type: { highlight: @sp_log_type.highlight } }
    end

    assert_redirected_to sp_log_type_url(SpLogType.last)
  end

  test "should show sp_log_type" do
    get sp_log_type_url(@sp_log_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_sp_log_type_url(@sp_log_type)
    assert_response :success
  end

  test "should update sp_log_type" do
    patch sp_log_type_url(@sp_log_type), params: { sp_log_type: { highlight: @sp_log_type.highlight } }
    assert_redirected_to sp_log_type_url(@sp_log_type)
  end

  test "should destroy sp_log_type" do
    assert_difference('SpLogType.count', -1) do
      delete sp_log_type_url(@sp_log_type)
    end

    assert_redirected_to sp_log_types_url
  end
end
