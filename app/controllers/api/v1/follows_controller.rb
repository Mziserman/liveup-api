class Api::V1::FollowsController < ApplicationController
  before_action :authenticate_request!
  before_action :authorize_user!, only: :destroy
  before_action :set_stream

  api :POST, '/v1/streams/:stream_id/follows', 'Follow streamer'
  param :stream_id, Integer, 'Stream id'
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


  api :DELETE, '/v1/streams/:stream_id/follows', 'Unfollow streamer'
  param :stream_id, Integer, 'Stream id'
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
