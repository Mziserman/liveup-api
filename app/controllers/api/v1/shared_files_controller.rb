class Api::V1::SharedFilesController < ApplicationController

  before_action :authenticate_request!, except: [:index]

  api :GET, '/v1/shared_files/credentials', 'Get Credentials'
  def credentials
    sts = Aws::STS::Client.new(region: 'eu-west-3')

    @resp = sts.get_session_token()

    render json: @resp.to_h
  end

  api :POST, '/v1/shared_files', 'Create File'
  param :shared_file, Hash, 'share_file object' do
    param :name, String, 'Sample name for all commits'
    param :path, String, 'Sample path for all commits'
  end
  def create

    @file = SharedFile.create(share_file_params)

    @current_user.streams.order('created_at ASC').first.shared_file = @file

    if @file.save
      render json: @file
    end

  end

  api :PUT, '/v1/shared_files/:shared_file_id', 'Update File'
  param :shared_file, Hash, 'share_file object' do
    param :name, String, 'Sample name for all commits'
  end
  def update
    @file = SharedFile.find(params[:shared_file_id])

    if @file.update(share_file_params)
      render json: @file
    else
      render json: @file.errors, head: :unprocessable_entity
    end
  end

  api :GET, '/v1/streams/:stream_id/shared_files', 'Index File for a stream'
  def index
    @stream = Stream.find(params[:stream_id])

    render json: @stream.shared_file
  end

  private

  def share_file_params
    params.require(:shared_file).permit(:name, :path)
  end

end