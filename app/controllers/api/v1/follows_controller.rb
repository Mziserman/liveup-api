class Api::V1::FollowsController < ApplicationController
  before_action :authenticate_request!
  before_action :set_channel
  before_action :authorize_user!, only: :destroy

  api :POST, '/v1/users/:channel_id/follows', 'Follow streamer'
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


  api :DELETE, '/v1/users/:channel_id/follows', 'Unfollow channel'
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
