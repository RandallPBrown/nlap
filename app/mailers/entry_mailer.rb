class EntryMailer < ApplicationMailer
  def entry_email(entry)
    @entry = entry
    mail(to: @entry.agent.user.email, subject: 'New Occurrence Logged')
  end
end
