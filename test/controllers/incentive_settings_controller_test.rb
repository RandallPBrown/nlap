require 'test_helper'

class IncentiveSettingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @incentive_setting = incentive_settings(:one)
  end

  test "should get index" do
    get incentive_settings_url
    assert_response :success
  end

  test "should get new" do
    get new_incentive_setting_url
    assert_response :success
  end

  test "should create incentive_setting" do
    assert_difference('IncentiveSetting.count') do
      post incentive_settings_url, params: { incentive_setting: { attendance: @incentive_setting.attendance, contracts: @incentive_setting.contracts, department_id: @incentive_setting.department_id, error: @incentive_setting.error, error_amount: @incentive_setting.error_amount, occupancy: @incentive_setting.occupancy, quality: @incentive_setting.quality, turntime: @incentive_setting.turntime, uph: @incentive_setting.uph } }
    end

    assert_redirected_to incentive_setting_url(IncentiveSetting.last)
  end

  test "should show incentive_setting" do
    get incentive_setting_url(@incentive_setting)
    assert_response :success
  end

  test "should get edit" do
    get edit_incentive_setting_url(@incentive_setting)
    assert_response :success
  end

  test "should update incentive_setting" do
    patch incentive_setting_url(@incentive_setting), params: { incentive_setting: { attendance: @incentive_setting.attendance, contracts: @incentive_setting.contracts, department_id: @incentive_setting.department_id, error: @incentive_setting.error, error_amount: @incentive_setting.error_amount, occupancy: @incentive_setting.occupancy, quality: @incentive_setting.quality, turntime: @incentive_setting.turntime, uph: @incentive_setting.uph } }
    assert_redirected_to incentive_setting_url(@incentive_setting)
  end

  test "should destroy incentive_setting" do
    assert_difference('IncentiveSetting.count', -1) do
      delete incentive_setting_url(@incentive_setting)
    end

    assert_redirected_to incentive_settings_url
  end
end
