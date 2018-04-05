class Api::V1::SubscriptionsController < ApplicationController
  
  before_action :authenticate_request!, only: [:create]

  Stripe.api_key = ENV["stripe_api"]

  def create
  

  end

 

end
