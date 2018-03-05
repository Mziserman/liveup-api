class Api::V1::UsersController < ApplicationController
  before_action :authenticate_request!, except: [:sign_in, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def sign_in
    @user = User.find_for_database_authentication(email: sign_in_params[:email])

    if @user.present? && @user.valid_password?(sign_in_params[:password])
      render json: @user,
        serializer: Api::V1::UserSerializer,
        token: JsonWebToken.encode(user_id: @user.id, exp: 6.hours.from_now.to_i)
    else
      render status: :error
    end
  end

  def index
    @users = User.all
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

  def update
    if @user.update(user_params)
      render json: @user, status: :ok
    else

    end
  end

  def destroy
    @user.destroy
  end

  def show
    render json: :user
  end

  private
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
      :first_name,
      :last_name)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
