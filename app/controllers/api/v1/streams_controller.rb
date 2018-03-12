class Api::V1::UsersController < ApplicationController
  before_action :authenticate_request!, except: [:index, :show]
  before_action :set_stream, only: [:show, :edit, :update, :destroy]

  def index
    @streams = Stream.all
  end

  def create

  end

  def show

  end
  def update

  end
  def destroy

  end

  private

  def stream_params
    params.require(:stream).permit(
      :user_id)
  end


  def set_stream
    @stream = Stream.find(params[:id])
  end

end
