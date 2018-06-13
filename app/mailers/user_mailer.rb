class UserMailer < ApplicationMailer

	def registration_confirmation
		@user = params[:user]
		mail(to: @user.email, subject: 'Welcome to Liveup !')
	end

end
