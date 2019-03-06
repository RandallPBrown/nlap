class ToolMailer < ApplicationMailer
  def tool_email(tool)
    @tool = tool
    mail(to: 'boesc@newleafsc.net', subject: 'OTL: ' + @tool.serviceorder)
  end
end
