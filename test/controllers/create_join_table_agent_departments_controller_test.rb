require 'test_helper'

class CreateJoinTableAgentDepartmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @create_join_table_agent_department = create_join_table_agent_departments(:one)
  end

  test "should get index" do
    get create_join_table_agent_departments_url
    assert_response :success
  end

  test "should get new" do
    get new_create_join_table_agent_department_url
    assert_response :success
  end

  test "should create create_join_table_agent_department" do
    assert_difference('CreateJoinTableAgentDepartment.count') do
      post create_join_table_agent_departments_url, params: { create_join_table_agent_department: { agent: @create_join_table_agent_department.agent, department: @create_join_table_agent_department.department } }
    end

    assert_redirected_to create_join_table_agent_department_url(CreateJoinTableAgentDepartment.last)
  end

  test "should show create_join_table_agent_department" do
    get create_join_table_agent_department_url(@create_join_table_agent_department)
    assert_response :success
  end

  test "should get edit" do
    get edit_create_join_table_agent_department_url(@create_join_table_agent_department)
    assert_response :success
  end

  test "should update create_join_table_agent_department" do
    patch create_join_table_agent_department_url(@create_join_table_agent_department), params: { create_join_table_agent_department: { agent: @create_join_table_agent_department.agent, department: @create_join_table_agent_department.department } }
    assert_redirected_to create_join_table_agent_department_url(@create_join_table_agent_department)
  end

  test "should destroy create_join_table_agent_department" do
    assert_difference('CreateJoinTableAgentDepartment.count', -1) do
      delete create_join_table_agent_department_url(@create_join_table_agent_department)
    end

    assert_redirected_to create_join_table_agent_departments_url
  end
end
