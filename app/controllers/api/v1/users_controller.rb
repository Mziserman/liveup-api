class Api::V1::UsersController < ApplicationController
  before_action :authenticate_request!, except: [:sign_in, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  Stripe.api_key = ENV["stripe_api"]

  def sign_in
    @user = User.find_for_database_authentication(email: sign_in_params[:email])

    if @user.present? && @user.valid_password?(sign_in_params[:password])
      render json: @user,
        serializer: Api::V1::UserSerializer,
        token: ::JsonWebToken.encode(user_id: @user.id, exp: 6.hours.from_now.to_i)
    else
      render status: :error
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user,
        status: :created
    else
      render json: @user.errors,
        status: :unauthorized
    end
  end

  def index
    @users = User.all
    render json: @users,
      status: :ok
  end

  def update
    if !@current_user == @user
      head :unauthorized
    end

    if @user.update(user_params)
      render json: @user, status: :ok
    else
      render json: @user.errors, head: :unprocessable_entity
    end
  end

  def destroy
    if !@current_user == @user
      return render json: [], status: :unauthorized
    end

    @user.destroy
    head :no_content
  end

  def show
    render json: @user
  end

  # api :POST, '/v1/products/:product_id/users', 'Subscribe user to product'
  def subscribe
    
    customer = checkCustomer(@current_user)

    if !customer
      render json: {"error": "User does not have payment infos"}
      return
    end

    product = StripeProduct.find(params.require(:product_id))

    plan = Stripe::Plan.create(
      :amount => product.price,
      :interval => "month",
      :currency => "eur",
      :product => {
        :name => "Subscription " + product.name
      }
    )

    subscription = Stripe::Subscription.create({
        customer: customer.id,
        items: [{plan: plan.id}],
    })

    if @subscription.save
      render json: @subscription
    end

  end

  private

  def checkCustomer(user)
    if user.stripe_id
      return Stripe::Customer.retrieve(user.stripe_id)
    else
     return false
    end
  end

  def sign_in_params
    params.require(:user).permit(
      :email,
      :password)
  end

  def user_params
    params.require(:user).permit(
      :email,
      :password,
      :password_confirmation,
      # :first_name,
      # :last_name
      )
  end

  def set_user
    @user = User.find(params[:id])
  end

end
