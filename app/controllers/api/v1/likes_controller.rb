class Api::V1::LikesController < ApplicationController
  before_action :authenticate_request!
  before_action :set_stream, except: :index
  before_action :authorize_user!, only: :destroy

  api :GET, '/v1/liked', 'Like index'
  def index
    @liked_streams = @current_user.liked_streams
    render json: @liked_streams
  end

  api :POST, '/v1/streams/:stream_id/likes', 'Like streamer'
  param :stream_id, String, 'Stream id'
  def create
    @like = Like.find_or_initialize_by(user: @current_user, stream: @stream)
    if @like.save
      render json: @like,
        status: :created
    else
      render json: @user.errors,
        status: :bad_request
    end
  end

  api :DELETE, '/v1/streams/:stream_id/likes', 'Unlike stream'
  param :stream_id, String, 'Stream id'
  def destroy
    Like.find_by(user: @current_user, stream: @stream).destroy
    head :no_content
  end

  private

  def set_stream
    @stream = Stream.find(params[:stream_id])
  end

  def authorize_user!
    if !@current_user.liked_streams.include?(@stream)
      return head :unauthorized
    end
  end

end
