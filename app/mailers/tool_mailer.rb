class ToolMailer < ApplicationMailer
  def tool_email(tool)
    @tool = tool
    mail(to: 'pbrown@newleafsc.net', subject: @tool.serviceorder)
  end
end
