require 'test_helper'

class NetworkMapsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @network_map = network_maps(:one)
  end

  test "should get index" do
    get network_maps_url
    assert_response :success
  end

  test "should get new" do
    get new_network_map_url
    assert_response :success
  end

  test "should create network_map" do
    assert_difference('NetworkMap.count') do
      post network_maps_url, params: { network_map: {  } }
    end

    assert_redirected_to network_map_url(NetworkMap.last)
  end

  test "should show network_map" do
    get network_map_url(@network_map)
    assert_response :success
  end

  test "should get edit" do
    get edit_network_map_url(@network_map)
    assert_response :success
  end

  test "should update network_map" do
    patch network_map_url(@network_map), params: { network_map: {  } }
    assert_redirected_to network_map_url(@network_map)
  end

  test "should destroy network_map" do
    assert_difference('NetworkMap.count', -1) do
      delete network_map_url(@network_map)
    end

    assert_redirected_to network_maps_url
  end
end
