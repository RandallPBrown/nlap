class AgentStat < ApplicationRecord
	require 'csv'
	belongs_to :user
end
