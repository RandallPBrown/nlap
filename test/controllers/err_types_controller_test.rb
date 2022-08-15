require 'test_helper'

class ErrTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @err_type = err_types(:one)
  end

  test "should get index" do
    get err_types_url
    assert_response :success
  end

  test "should get new" do
    get new_err_type_url
    assert_response :success
  end

  test "should create err_type" do
    assert_difference('ErrType.count') do
      post err_types_url, params: { err_type: { description: @err_type.description } }
    end

    assert_redirected_to err_type_url(ErrType.last)
  end

  test "should show err_type" do
    get err_type_url(@err_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_err_type_url(@err_type)
    assert_response :success
  end

  test "should update err_type" do
    patch err_type_url(@err_type), params: { err_type: { description: @err_type.description } }
    assert_redirected_to err_type_url(@err_type)
  end

  test "should destroy err_type" do
    assert_difference('ErrType.count', -1) do
      delete err_type_url(@err_type)
    end

    assert_redirected_to err_types_url
  end
end
