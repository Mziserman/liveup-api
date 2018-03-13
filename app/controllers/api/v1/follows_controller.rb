class Api::V1::FollowsController < ApplicationController
  before_action :authenticate_request!
  before_action :authorize_user!, only: :destroy
  before_action :set_stream


  api :POST, '/api/v1/streams/:stream_id/follows'
  param :stream_id, Integer
  def create
    @follow = Follow.find_or_initialize_by(user: @current_user, stream: @stream)
    if @follow.save
      render json: @follow,
        status: :created
    else
      render json: @user.errors,
        status: :bad_request
    end
  end


  api :DELETE, '/api/v1/streams/:stream_id/follows'
  param :stream_id, Integer
  def destroy
    Follow.find_by(user: @current_user, stream: @stream).destroy
    head :no_content
  end

  private

  def set_stream
    @stream = Stream.find(params[:stream_id])
  end

  def authorize_user!
    if !@current_user.followed_streams.include?(@stream)
      return head :unauthorized
    end
  end

end
