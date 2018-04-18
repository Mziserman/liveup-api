class Api::V1::ShareFilesController < ApplicationController

  before_action :authenticate_request!, except: [:index]

  api :POST, '/api/v1/share_files', 'Create File'
  param :share_file, String, 'share_file object contain the following arguments'
  param :name, String, 'Sample name for all commits'
  param :path, String, 'Sample path for all commits'
  def create

    @file = ShareFile.create(params.require(:share_file).permit(:name, :path))

    @current_user.streams.last.share_file = @file

    if @file.save
      render json: @file
    end

  end

  api :PUT, '/api/v1/share_files/:share_file_id', 'Update File'
  param :share_file, String, 'share_file object contain the following arguments'
  param :name, String, 'Sample name for all commits'
  def update
    @file = ShareFile.find(params[:share_file_id])

    if @file.update(params.require(:share_file).permit(:name))
      render json: @file
    else
      render json: @file.errors, head: :unprocessable_entity
    end
  end

  api :GET, '/api/v1/streams/:stream_id/share_files', 'Index File for a stream'
  def index
    @stream = Stream.find(params[:stream_id])

    render json: @stream.share_file
  end

end