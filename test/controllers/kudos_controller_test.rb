require 'test_helper'

class KudosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @kudo = kudos(:one)
  end

  test "should get index" do
    get kudos_url
    assert_response :success
  end

  test "should get new" do
    get new_kudo_url
    assert_response :success
  end

  test "should create kudo" do
    assert_difference('Kudo.count') do
      post kudos_url, params: { kudo: { date: @kudo.date, description: @kudo.description, kudo_reason_id: @kudo.kudo_reason_id, status: @kudo.status, submitted_by: @kudo.submitted_by, user_id: @kudo.user_id } }
    end

    assert_redirected_to kudo_url(Kudo.last)
  end

  test "should show kudo" do
    get kudo_url(@kudo)
    assert_response :success
  end

  test "should get edit" do
    get edit_kudo_url(@kudo)
    assert_response :success
  end

  test "should update kudo" do
    patch kudo_url(@kudo), params: { kudo: { date: @kudo.date, description: @kudo.description, kudo_reason_id: @kudo.kudo_reason_id, status: @kudo.status, submitted_by: @kudo.submitted_by, user_id: @kudo.user_id } }
    assert_redirected_to kudo_url(@kudo)
  end

  test "should destroy kudo" do
    assert_difference('Kudo.count', -1) do
      delete kudo_url(@kudo)
    end

    assert_redirected_to kudos_url
  end
end
