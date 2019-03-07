class ToolMailer < ApplicationMailer
  def tool_email(tool)
    @tool = tool
    mail(to: 'pbrown@newleafsc.net', subject: 'OTL: ' + @tool.serviceorder)
  end
end
