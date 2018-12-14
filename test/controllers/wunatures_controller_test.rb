require 'test_helper'

class WunaturesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @wunature = wunatures(:one)
  end

  test "should get index" do
    get wunatures_url
    assert_response :success
  end

  test "should get new" do
    get new_wunature_url
    assert_response :success
  end

  test "should create wunature" do
    assert_difference('Wunature.count') do
      post wunatures_url, params: { wunature: { description: @wunature.description } }
    end

    assert_redirected_to wunature_url(Wunature.last)
  end

  test "should show wunature" do
    get wunature_url(@wunature)
    assert_response :success
  end

  test "should get edit" do
    get edit_wunature_url(@wunature)
    assert_response :success
  end

  test "should update wunature" do
    patch wunature_url(@wunature), params: { wunature: { description: @wunature.description } }
    assert_redirected_to wunature_url(@wunature)
  end

  test "should destroy wunature" do
    assert_difference('Wunature.count', -1) do
      delete wunature_url(@wunature)
    end

    assert_redirected_to wunatures_url
  end
end
