require 'test_helper'

class WriteupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @writeup = writeups(:one)
  end

  test "should get index" do
    get writeups_url
    assert_response :success
  end

  test "should get new" do
    get new_writeup_url
    assert_response :success
  end

  test "should create writeup" do
    assert_difference('Writeup.count') do
      post writeups_url, params: { writeup: { desc: @writeup.desc, type: @writeup.type, wdate: @writeup.wdate } }
    end

    assert_redirected_to writeup_url(Writeup.last)
  end

  test "should show writeup" do
    get writeup_url(@writeup)
    assert_response :success
  end

  test "should get edit" do
    get edit_writeup_url(@writeup)
    assert_response :success
  end

  test "should update writeup" do
    patch writeup_url(@writeup), params: { writeup: { desc: @writeup.desc, type: @writeup.type, wdate: @writeup.wdate } }
    assert_redirected_to writeup_url(@writeup)
  end

  test "should destroy writeup" do
    assert_difference('Writeup.count', -1) do
      delete writeup_url(@writeup)
    end

    assert_redirected_to writeups_url
  end
end
