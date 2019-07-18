require 'test_helper'

class PcmiImportsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pcmi_import = pcmi_imports(:one)
  end

  test "should get index" do
    get pcmi_imports_url
    assert_response :success
  end

  test "should get new" do
    get new_pcmi_import_url
    assert_response :success
  end

  test "should create pcmi_import" do
    assert_difference('PcmiImport.count') do
      post pcmi_imports_url, params: { pcmi_import: { claim: @pcmi_import.claim, email: @pcmi_import.email, first_name: @pcmi_import.first_name, invoice: @pcmi_import.invoice, last_name: @pcmi_import.last_name, priority: @pcmi_import.priority, repair_date: @pcmi_import.repair_date, report_date: @pcmi_import.report_date, servicer: @pcmi_import.servicer, status: @pcmi_import.status } }
    end

    assert_redirected_to pcmi_import_url(PcmiImport.last)
  end

  test "should show pcmi_import" do
    get pcmi_import_url(@pcmi_import)
    assert_response :success
  end

  test "should get edit" do
    get edit_pcmi_import_url(@pcmi_import)
    assert_response :success
  end

  test "should update pcmi_import" do
    patch pcmi_import_url(@pcmi_import), params: { pcmi_import: { claim: @pcmi_import.claim, email: @pcmi_import.email, first_name: @pcmi_import.first_name, invoice: @pcmi_import.invoice, last_name: @pcmi_import.last_name, priority: @pcmi_import.priority, repair_date: @pcmi_import.repair_date, report_date: @pcmi_import.report_date, servicer: @pcmi_import.servicer, status: @pcmi_import.status } }
    assert_redirected_to pcmi_import_url(@pcmi_import)
  end

  test "should destroy pcmi_import" do
    assert_difference('PcmiImport.count', -1) do
      delete pcmi_import_url(@pcmi_import)
    end

    assert_redirected_to pcmi_imports_url
  end
end
