class Api::V1::ProductsController < ApplicationController
  
  before_action :authenticate_request!, except: [:show, :update]

  Stripe.api_key = ENV["stripe_api"]

  api :GET, 'api/v1/products/:id', 'Get a product by id'
  def show

    if params[:user_id]
      render json: User.find(params[:user_id]).stripe_product
    else
      if @product = StripeProduct.find(params.require(:id))
        render json: @product
      else
        render json: @product.errors
      end
    end

  end

  api :GET, 'api/v1/products', 'Get all products from user id'
  def index
    render json: StripeProduct.all()
  end

  def buy

    customer = User.checkCustomer(@current_user)

    if !customer
      render json: {'error': 'customer does not exist. You should consider creating it by using this => /api/v1/customers POST#CREATE. Have a nice day !'}
      return
    end

    product = StripeProduct.find(params.require(:product_id))

    @subscription = Stripe::Subscription.create({
      customer: customer.id,
      items: [{plan: product.stripe_id}],
    })

    render json: @subscription

  end

end