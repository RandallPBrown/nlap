class ToolMailer < ApplicationMailer
  def tool_email(tool)
    @tool = tool
    mail(to: 'pbrown@newleafsc.net', subject: 'New Occurrence Logged')
  end
end
