class Api::V1::ProductsController < ApplicationController

  before_action :authenticate_request!, except: [:create, :show, :update]

  Stripe.api_key = "sk_test_BQokikJOvBiI2HlWgH4olfQ2"

  api :POST, '/v1/products', 'Create products'
  def create

    @product = StripeProduct.new(params.require(:product).permit(:price, :name))

    @current_user.stripe_products << @product

    if @current_user.save
      render json: @product
    end

  end

  api :GET, '/v1/products/:id', 'Get a product by id'
  def show

    if @product = StripeProduct.find(params.require(:id))
      render json: @product
    else
      render json: @product.errors
    end

  end

  api :GET, '/v1/users/:id/products', 'Get all products from user id'
  def index
      render json: @current_user.stripe_products
  end

  api :PUT, '/v1/products/:id', 'Update a product'
  def update

    @product = StripeProduct.find(params.require(:id))

    if @product.update(params.require(:product).permit(:price, :name))
      render json: @product
    else
      render json: @product.errors, head: :unprocessable_entity
    end

  end

  api :DELETE, '/v1/products/:id', 'Delete a product'
  def destroy

    @product = StripeProduct.find(params.require(:id))

    if @product.destroy
      render json: {deleted: true}
    end

  end

end