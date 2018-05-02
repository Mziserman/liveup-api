class Api::V1::CustomersController < ApplicationController

  before_action :authenticate_request!, only: [:create]

  Stripe.api_key = ENV["stripe_api"]

  api :POST, 'api/v1/customers', 'Create stripe customer and save it into the user.'
  def create

    if @current_user.stripe_id
      render json: @current_user
      return
    end

    customer = Stripe::Customer.create({
        source: params[:stripe_token],
        email: @current_user.email
    })

    @current_user.stripe_id = customer.id

    if @current_user.save
      render json: @current_user
    end

  end

end