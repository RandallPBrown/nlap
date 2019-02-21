require 'test_helper'

class BuyingGroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @buying_group = buying_groups(:one)
  end

  test "should get index" do
    get buying_groups_url
    assert_response :success
  end

  test "should get new" do
    get new_buying_group_url
    assert_response :success
  end

  test "should create buying_group" do
    assert_difference('BuyingGroup.count') do
      post buying_groups_url, params: { buying_group: { bgname: @buying_group.bgname } }
    end

    assert_redirected_to buying_group_url(BuyingGroup.last)
  end

  test "should show buying_group" do
    get buying_group_url(@buying_group)
    assert_response :success
  end

  test "should get edit" do
    get edit_buying_group_url(@buying_group)
    assert_response :success
  end

  test "should update buying_group" do
    patch buying_group_url(@buying_group), params: { buying_group: { bgname: @buying_group.bgname } }
    assert_redirected_to buying_group_url(@buying_group)
  end

  test "should destroy buying_group" do
    assert_difference('BuyingGroup.count', -1) do
      delete buying_group_url(@buying_group)
    end

    assert_redirected_to buying_groups_url
  end
end
