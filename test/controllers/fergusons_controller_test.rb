require 'test_helper'

class FergusonsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ferguson = fergusons(:one)
  end

  test "should get index" do
    get fergusons_url
    assert_response :success
  end

  test "should get new" do
    get new_ferguson_url
    assert_response :success
  end

  test "should create ferguson" do
    assert_difference('Ferguson.count') do
      post fergusons_url, params: { ferguson: { address: @ferguson.address, customer_fo: @ferguson.customer_fo, customer_name: @ferguson.customer_name, dealer_fo: @ferguson.dealer_fo, district_id: @ferguson.district_id, escalated: @ferguson.escalated, leaking: @ferguson.leaking, manufacturer: @ferguson.manufacturer, model: @ferguson.model, product: @ferguson.product, servicer_fo: @ferguson.servicer_fo, so_number: @ferguson.so_number, sp_name: @ferguson.sp_name, user_id: @ferguson.user_id } }
    end

    assert_redirected_to ferguson_url(Ferguson.last)
  end

  test "should show ferguson" do
    get ferguson_url(@ferguson)
    assert_response :success
  end

  test "should get edit" do
    get edit_ferguson_url(@ferguson)
    assert_response :success
  end

  test "should update ferguson" do
    patch ferguson_url(@ferguson), params: { ferguson: { address: @ferguson.address, customer_fo: @ferguson.customer_fo, customer_name: @ferguson.customer_name, dealer_fo: @ferguson.dealer_fo, district_id: @ferguson.district_id, escalated: @ferguson.escalated, leaking: @ferguson.leaking, manufacturer: @ferguson.manufacturer, model: @ferguson.model, product: @ferguson.product, servicer_fo: @ferguson.servicer_fo, so_number: @ferguson.so_number, sp_name: @ferguson.sp_name, user_id: @ferguson.user_id } }
    assert_redirected_to ferguson_url(@ferguson)
  end

  test "should destroy ferguson" do
    assert_difference('Ferguson.count', -1) do
      delete ferguson_url(@ferguson)
    end

    assert_redirected_to fergusons_url
  end
end
