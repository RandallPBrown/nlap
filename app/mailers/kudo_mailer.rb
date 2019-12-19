class KudoMailer < ApplicationMailer
	def new_kudo_email(kudo)
	    @kudo = kudo
	    mail(to: 'pbrown@newleafsc.net', subject: 'New Kudos Submission: ' + @kudo.user.full_name.to_s )
  	end
end
