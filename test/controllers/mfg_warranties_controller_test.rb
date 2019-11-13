require 'test_helper'

class MfgWarrantiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @mfg_warranty = mfg_warranties(:one)
  end

  test "should get index" do
    get mfg_warranties_url
    assert_response :success
  end

  test "should get new" do
    get new_mfg_warranty_url
    assert_response :success
  end

  test "should create mfg_warranty" do
    assert_difference('MfgWarranty.count') do
      post mfg_warranties_url, params: { mfg_warranty: { dop: @mfg_warranty.dop, model_number: @mfg_warranty.model_number, warranty_link: @mfg_warranty.warranty_link } }
    end

    assert_redirected_to mfg_warranty_url(MfgWarranty.last)
  end

  test "should show mfg_warranty" do
    get mfg_warranty_url(@mfg_warranty)
    assert_response :success
  end

  test "should get edit" do
    get edit_mfg_warranty_url(@mfg_warranty)
    assert_response :success
  end

  test "should update mfg_warranty" do
    patch mfg_warranty_url(@mfg_warranty), params: { mfg_warranty: { dop: @mfg_warranty.dop, model_number: @mfg_warranty.model_number, warranty_link: @mfg_warranty.warranty_link } }
    assert_redirected_to mfg_warranty_url(@mfg_warranty)
  end

  test "should destroy mfg_warranty" do
    assert_difference('MfgWarranty.count', -1) do
      delete mfg_warranty_url(@mfg_warranty)
    end

    assert_redirected_to mfg_warranties_url
  end
end
