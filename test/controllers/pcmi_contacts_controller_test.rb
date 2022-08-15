require 'test_helper'

class PcmiContactsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pcmi_contact = pcmi_contacts(:one)
  end

  test "should get index" do
    get pcmi_contacts_url
    assert_response :success
  end

  test "should get new" do
    get new_pcmi_contact_url
    assert_response :success
  end

  test "should create pcmi_contact" do
    assert_difference('PcmiContact.count') do
      post pcmi_contacts_url, params: { pcmi_contact: { email: @pcmi_contact.email, name: @pcmi_contact.name } }
    end

    assert_redirected_to pcmi_contact_url(PcmiContact.last)
  end

  test "should show pcmi_contact" do
    get pcmi_contact_url(@pcmi_contact)
    assert_response :success
  end

  test "should get edit" do
    get edit_pcmi_contact_url(@pcmi_contact)
    assert_response :success
  end

  test "should update pcmi_contact" do
    patch pcmi_contact_url(@pcmi_contact), params: { pcmi_contact: { email: @pcmi_contact.email, name: @pcmi_contact.name } }
    assert_redirected_to pcmi_contact_url(@pcmi_contact)
  end

  test "should destroy pcmi_contact" do
    assert_difference('PcmiContact.count', -1) do
      delete pcmi_contact_url(@pcmi_contact)
    end

    assert_redirected_to pcmi_contacts_url
  end
end
