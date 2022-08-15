require 'test_helper'

class MfgPartsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @mfg_part = mfg_parts(:one)
  end

  test "should get index" do
    get mfg_parts_url
    assert_response :success
  end

  test "should get new" do
    get new_mfg_part_url
    assert_response :success
  end

  test "should create mfg_part" do
    assert_difference('MfgPart.count') do
      post mfg_parts_url, params: { mfg_part: { manufacturer_id: @mfg_part.manufacturer_id, part_name: @mfg_part.part_name, part_number: @mfg_part.part_number } }
    end

    assert_redirected_to mfg_part_url(MfgPart.last)
  end

  test "should show mfg_part" do
    get mfg_part_url(@mfg_part)
    assert_response :success
  end

  test "should get edit" do
    get edit_mfg_part_url(@mfg_part)
    assert_response :success
  end

  test "should update mfg_part" do
    patch mfg_part_url(@mfg_part), params: { mfg_part: { manufacturer_id: @mfg_part.manufacturer_id, part_name: @mfg_part.part_name, part_number: @mfg_part.part_number } }
    assert_redirected_to mfg_part_url(@mfg_part)
  end

  test "should destroy mfg_part" do
    assert_difference('MfgPart.count', -1) do
      delete mfg_part_url(@mfg_part)
    end

    assert_redirected_to mfg_parts_url
  end
end
