class AgentDepartment < ApplicationRecord
	belongs_to :agent
	belongs_to :department
end
