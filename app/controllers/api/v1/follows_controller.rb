class Api::V1::FollowsController < ApplicationController
  before_action :authenticate_request!
  before_action :set_channel, except: :index
  before_action :authorize_user!, only: :destroy

  api :GET, '/v1/users/follows', 'Follow index'
  def index
    @followed_channels = @current_user.followed_channels
    render json: @followed_channels
  end

  api :POST, '/v1/channels/:channel_id/follows', 'Follow streamer'
  param :channel_id, String, 'Channel id'
  def create
    @follow = Follow.find_or_initialize_by(follower: @current_user, channel: @channel)
    if @follow.save
      render json: @follow,
        status: :created
    else
      render json: @user.errors,
        status: :bad_request
    end
  end


  api :DELETE, '/v1/channels/:channel_id/follows', 'Unfollow channel'
  param :channel_id, String, 'Channel id'
  def destroy
    Follow.find_by(follower: @current_user, channel: @channel).destroy
    head :no_content
  end

  private

  def set_channel
    @channel = Channel.find(params[:channel_id])
  end

  def authorize_user!
    if !@current_user.followed_channels.include?(@channel)
      return head :unauthorized
    end
  end

end
