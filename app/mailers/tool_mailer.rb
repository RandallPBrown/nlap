class ToolMailer < ApplicationMailer


  def tool_email(tool, recipient)
    @tool = tool
    mail(to: recipient.user.email, subject: 'OTL: ' + @tool.serviceorder)
  end
end
