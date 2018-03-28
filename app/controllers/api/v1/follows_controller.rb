class Api::V1::FollowsController < ApplicationController
  before_action :authenticate_request!
  before_action :set_streamer
  before_action :authorize_user!, only: :destroy

  api :POST, '/v1/users/:user_id/follows', 'Follow streamer'
  param :user_id, String, 'Stream id'
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


  api :DELETE, '/v1/users/:user_id/follows', 'Unfollow channel'
  param :user_id, String, 'Stream id'
  def destroy
    Follow.find_by(follower: @current_user, channel: @channel).destroy
    head :no_content
  end

  private

  def set_streamer
    @channel = Channel.find(params[:channel_id])
  end

  def authorize_user!
    if !@current_user.followed_streamers.include?(@streamer)
      return head :unauthorized
    end
  end

end
