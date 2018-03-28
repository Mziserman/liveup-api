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
  def create
    @channel = @current_user.create_channel(channel_params)

    if @channel.save
      render json: @channel,
        status: :created
    else
      render json: @user.errors,
        status: :bad_request
    end
  end

  api :GET, '/v1/channels/:id', 'Show channel'
  param :id, String, 'Channel id'
  def show
    @channel = Channel.find(params[:id])

    render json: @channel,
      status: :ok
  end

  api :PUT, '/v1/channels/:id', 'Update channel'
  param :id, String, 'Channel id'
  def update
    @channel = Channel.find(params[:id])
    if @channel.update(channel_params)
      render json: @channel,
        status: :updated
    else
      render json: @channel.errors,
        status: :bad_request
    end
  end

  api :DELETE, '/v1/channels/:id', 'Delete channel'
  param :id, String, 'Channel id'
  def destroy
    @channel.destroy
    head :no_content
  end

  private

  def channel_params
    params.require(:channel).permit(
      :user_id,
      :name)
  end


  def set_channel
    @channel = Channel.find(params[:id])
  end

  def authorize_user!
    if @current_user != @channel.streamer
      return head :unauthorized
    end
  end

end
