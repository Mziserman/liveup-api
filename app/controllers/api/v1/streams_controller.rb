class Api::V1::StreamsController < ApplicationController
  before_action :authenticate_request!, except: [:index, :show]
  before_action :authorize_user!, except: [:index, :create, :show, :follow]
  before_action :set_stream, only: [:show, :edit, :update, :destroy, :follow]

  def index
    @streams = Stream.all
    render json: @streams,
      status: :ok
  end

  def create
    @stream = @current_user.streams.new
    if @stream.save
      render json: @stream,
        status: :created
    else
      render json: @user.errors,
        status: :bad_request
    end
  end

  def show
    @stream = Stream.find(params[:id])
    render json: @stream,
      status: :ok
  end

  def update
    @stream = Stream.find(params[:id])
    if @stream.update(stream_params)
      render json: @stream,
        status: :updated
    else
      render json: @stream.errors,
        status: :bad_request
    end
  end

  def destroy
    @stream.destroy
    head :no_content
  end

  private

  def stream_params
    params.require(:stream).permit(
      :user_id)
  end


  def set_stream
    @stream = Stream.find(params[:id])
  end

  def authorize_user!
    if @current_user != @stream.streamer
      return head :unauthorized
    end
  end

end
