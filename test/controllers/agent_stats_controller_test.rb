require 'test_helper'

class AgentStatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @agent_stat = agent_stats(:one)
  end

  test "should get index" do
    get agent_stats_url
    assert_response :success
  end

  test "should get new" do
    get new_agent_stat_url
    assert_response :success
  end

  test "should create agent_stat" do
    assert_difference('AgentStat.count') do
      post agent_stats_url, params: { agent_stat: { acw: @agent_stat.acw, aht: @agent_stat.aht, availability: @agent_stat.availability, callback_calls: @agent_stat.callback_calls, callback_talk: @agent_stat.callback_talk, date: @agent_stat.date, deleted: @agent_stat.deleted, direct_calls: @agent_stat.direct_calls, direct_talk: @agent_stat.direct_talk, extension: @agent_stat.extension, name: @agent_stat.name, net_login: @agent_stat.net_login, occupancy: @agent_stat.occupancy, outbound_calls: @agent_stat.outbound_calls, outbound_talk: @agent_stat.outbound_talk, picked: @agent_stat.picked, power_dial: @agent_stat.power_dial, queue_calls: @agent_stat.queue_calls, queue_talk: @agent_stat.queue_talk, recover: @agent_stat.recover, requested_worktime: @agent_stat.requested_worktime, shift: @agent_stat.shift, total_break: @agent_stat.total_break, total_calls: @agent_stat.total_calls, total_login: @agent_stat.total_login, total_talk: @agent_stat.total_talk, un_ans: @agent_stat.un_ans, wrapup_time: @agent_stat.wrapup_time } }
    end

    assert_redirected_to agent_stat_url(AgentStat.last)
  end

  test "should show agent_stat" do
    get agent_stat_url(@agent_stat)
    assert_response :success
  end

  test "should get edit" do
    get edit_agent_stat_url(@agent_stat)
    assert_response :success
  end

  test "should update agent_stat" do
    patch agent_stat_url(@agent_stat), params: { agent_stat: { acw: @agent_stat.acw, aht: @agent_stat.aht, availability: @agent_stat.availability, callback_calls: @agent_stat.callback_calls, callback_talk: @agent_stat.callback_talk, date: @agent_stat.date, deleted: @agent_stat.deleted, direct_calls: @agent_stat.direct_calls, direct_talk: @agent_stat.direct_talk, extension: @agent_stat.extension, name: @agent_stat.name, net_login: @agent_stat.net_login, occupancy: @agent_stat.occupancy, outbound_calls: @agent_stat.outbound_calls, outbound_talk: @agent_stat.outbound_talk, picked: @agent_stat.picked, power_dial: @agent_stat.power_dial, queue_calls: @agent_stat.queue_calls, queue_talk: @agent_stat.queue_talk, recover: @agent_stat.recover, requested_worktime: @agent_stat.requested_worktime, shift: @agent_stat.shift, total_break: @agent_stat.total_break, total_calls: @agent_stat.total_calls, total_login: @agent_stat.total_login, total_talk: @agent_stat.total_talk, un_ans: @agent_stat.un_ans, wrapup_time: @agent_stat.wrapup_time } }
    assert_redirected_to agent_stat_url(@agent_stat)
  end

  test "should destroy agent_stat" do
    assert_difference('AgentStat.count', -1) do
      delete agent_stat_url(@agent_stat)
    end

    assert_redirected_to agent_stats_url
  end
end
