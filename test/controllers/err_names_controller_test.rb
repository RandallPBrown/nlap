require 'test_helper'

class ErrNamesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @err_name = err_names(:one)
  end

  test "should get index" do
    get err_names_url
    assert_response :success
  end

  test "should get new" do
    get new_err_name_url
    assert_response :success
  end

  test "should create err_name" do
    assert_difference('ErrName.count') do
      post err_names_url, params: { err_name: { errname: @err_name.errname } }
    end

    assert_redirected_to err_name_url(ErrName.last)
  end

  test "should show err_name" do
    get err_name_url(@err_name)
    assert_response :success
  end

  test "should get edit" do
    get edit_err_name_url(@err_name)
    assert_response :success
  end

  test "should update err_name" do
    patch err_name_url(@err_name), params: { err_name: { errname: @err_name.errname } }
    assert_redirected_to err_name_url(@err_name)
  end

  test "should destroy err_name" do
    assert_difference('ErrName.count', -1) do
      delete err_name_url(@err_name)
    end

    assert_redirected_to err_names_url
  end
end
