class ToolsController < ApplicationController

	def validator
		@tools = Tools.all
	end
end
