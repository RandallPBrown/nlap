class DapMailer < ApplicationMailer
  def dap_email(dap)
    @dap = dap
    mail(to: @dap.user.email, subject: 'New Entry Logged')
  end
end
