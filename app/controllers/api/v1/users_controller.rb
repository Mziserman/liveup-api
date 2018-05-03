class Api::V1::UsersController < ApplicationController
  before_action :authenticate_request!, except: [:sign_in, :create, :reconnect, :show]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, except: [:sign_in, :create, :index, :show]

  api :POST, '/v1/users/sign_in', 'Login'
  param :email, String, 'User email'
  param :password, String, 'User password'
  def sign_in
    @user = User.find_for_database_authentication(email: sign_in_params[:email])

    if @user.present? && @user.valid_password?(sign_in_params[:password])
      auth_token = ::JsonWebToken.encode(user_id: @user.id, exp: 6.hours.from_now.to_i)

      refresh_token = if @user.refresh_token.nil?
        ::JsonWebToken.encode(user_id: @user.id, exp: 1.year.from_now.to_i)
      else
        @user.refresh_token
      end

      @user.update(refresh_token: refresh_token)

      render json: @user,
        serializer: Api::V1::UserSerializer,
        auth_token: auth_token,
        refresh_token: refresh_token

    else
      render [], status: :unauthorized
    end
  end

  api :POST, '/v1/users/reconnect', 'reconnect requires refresh token'
  def reconnect
    reconnect_user!
    auth_token = ::JsonWebToken.encode(user_id: @current_user.id, exp: 6.hours.from_now.to_i)
    refresh_token = @current_user.refresh_token

    render json: @current_user,
      serializer: Api::V1::UserSerializer,
      auth_token: auth_token,
      refresh_token: refresh_token
  end

  api :POST, '/v1/users', 'Create user'
  param :email, String, 'User email'
  param :password, String, 'User password'
  param :pseudo, String, 'User pseudo'
  param :first_name, String, 'User first_name'
  param :last_name, String, 'User last_name'
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user,
        status: :created
    else
      render json: @user.errors,
        status: :bad_request
    end
  end

  api :GET, '/v1/users', 'List users'
  def index
    @users = User.all
    render json: @users,
      status: :ok
  end

  api :PUT, '/v1/users/:id', 'Update user'
  param :id, String, 'User id'
  param :email, String, 'User email'
  param :password, String, 'User password'
  param :pseudo, String, 'User pseudo'
  param :first_name, String, 'User first_name'
  param :last_name, String, 'User last_name'
  def update
    if @user.update(user_params)
      refresh_token = ::JsonWebToken.encode(user_id: @current_user.id, exp: 1.year.from_now.to_i)
      @current_user.update(refresh_token: refresh_token)
      render json: @user,
        serializer: Api::V1::UserSerializer,
        refresh_token: refresh_token,
        status: :ok
    else
      render json: @user.errors,
        status: :bad_request
    end
  end

  api :DELETE, '/v1/users/:id', 'Destroy user'
  param :id, String, 'User id'
  def destroy
    @user.destroy
    head :no_content
  end

  api :GET, '/v1/users/:id', 'Show user'
  param :id, String, 'User id'
  def show
    render json: @user
  end

  api :GET, '/v1/users/interested', 'Show user'
  param :email, String, 'User email'
  def interested
    InterestedUser.create(params.require(:user).permit(:email))
  end

  api :GET, '/v1/users/:user_id/owned_streams', 'Get all user\'s favorites streams / bought streams'
  def owned_streams
    render json: @user.owned_streams
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
      :pseudo,
      :first_name,
      :last_name)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def authorize_user!
    if @current_user != @user
      return head :unauthorized
    end
  end

end
