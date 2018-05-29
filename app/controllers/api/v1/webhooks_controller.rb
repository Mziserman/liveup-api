class Api::V1::WebhooksController < ApplicationController

	def mail_webhook

		gibbon = Gibbon::Request.new(api_key: ENV["MAILCHIMP_KEY"])

		if params[:email]
			gibbon
			.lists(ENV["MAILCHIMP_LIST_ID"])
			.members
			.create(
				body: 
				{
					email_address: params.require(:email), 
					status: "subscribed", 
				}
			)
			render json: {response: 'Email inserted'}
		else 
			render json: {error: 'Email field missing'}
		end
	else
		render json: {error: 'Domain not authorized'}
	end

end