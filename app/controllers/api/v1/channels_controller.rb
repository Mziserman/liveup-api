class Api::V1::ChannelsController < ApplicationController
  before_action :authenticate_request!, except: [:index, :show]
  before_action :authorize_user!, except: [:index, :create, :show]
  before_action :set_channel, only: [:show, :edit, :update, :destroy]

  api :GET, '/v1/channels', 'List channels'
  def index
    @channels = Channel.all
    render json: @channels
  end

  api :POST, '/v1/channels', 'Create channel'
  param :name, String, 'Channel name'
  param :user_id, Integer, 'User id'
  def create
    @channel = @current_user.channel ?
      @current_user.channel :
      @current_user.create_channel(channel_params)

    if @channel
      render json: @channel,
        status: :created
    else
      render json: @channel.errors,
        status: :bad_request
    end
  end

  api :GET, '/v1/channels/:slug', 'Show channel'
  param :slug, String, 'Channel slug'
  def show
    render json: @channel,
      status: :ok
  end

  api :PUT, '/v1/channels/:slug', 'Update channel'
  param :slug, String, 'Channel slug'
  param :name, String, 'Channel name'
  param :user_id, Integer, 'User id'
  def update
    if @channel.update(channel_params)
      render json: @channel,
        status: :ok
    else
      render json: @channel.errors,
        status: :bad_request
    end
  end

  api :DELETE, '/v1/channels/:slug', 'Delete channel'
  param :slug, String, 'Channel slug'
  def destroy
    @channel.destroy
    head :no_content
  end

  private

  def channel_params
    params.require(:channel).permit(
      :user_id,
      :name,
      :channel_type,
      :aws_channel_id,
      :aws_input_id)
  end


  def set_channel
    @channel = Channel.find_by(slug: params[:id])
  end

  def authorize_user!
    if @current_user != @channel.streamer
      return head :unauthorized
    end
  end

end
