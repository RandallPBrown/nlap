class KudoMailer < ApplicationMailer
	def new_kudo_email(kudo, recipient)
	    @kudo = kudo
	    mail(to: recipient.user.email, subject: 'New Kudos Submission: ' + @kudo.user.full_name.to_s )
  	end
end
