class Api::V1::SubController < ApplicationController
  before_action :authenticate_request!, except: [:sign_in]
  before_action :set_sub, only: [:show, :edit, :update, :destroy]

  Stripe.api_key = "sk_test_BQokikJOvBiI2HlWgH4olfQ2"

  def create

    @product = StripeProduct.new(params.require(:product).permit(:price, :name))

    @current_user.stripe_products << @product

    if @current_user.save
      render json: @product
    end

  end

end