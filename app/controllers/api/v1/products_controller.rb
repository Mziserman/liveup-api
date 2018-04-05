class Api::V1::ProductsController < ApplicationController
  
  before_action :authenticate_request!, except: [:show, :update]

  # api :GET, '/v1/products/:id', 'Get a product by id'
  def show

    if @product = StripeProduct.find(params.require(:id))
      render json: @product
    else
      render json: @product.errors
    end

  end

  # api :GET, '/v1/users/:id/products', 'Get all products from user id'
  def index
      render json: StripeProduct.all()
  end

end