class Api::V1::CommitsController < ApplicationController
  
  before_action :authenticate_request!, except: [:index, :show]

  api :POST, '/api/v1/shared_files/:shared_files_id/commits', 'Create commit'
  param :commit, Hash, 'Commit object' do
    param :name, String, 'Name of commit'
    param :path, String, 'Path of file'
  end
  def create
    file = SharedFile.find(params[:shared_file_id])

    if @commit = file.commits.create(commit_param)
      render json: @commit
    end

  end

  api :PUT, '/api/v1/commits/:commit_id', 'Update commit'
  param :commit, Hash, 'Commit object' do
    param :name, String, 'Name of commit'
  end
  def update

    @commit = Commit.find(params[:commit_id])

    if @commit.update(commit_param)
      render json: @commit
    else
      render json: @commit.errors, head: :unprocessable_entity
    end

  end

  api :GET, '/api/v1/streams/:stream_id/commits', 'Show all commits for a stream'
  def index
    @stream = Stream.find(params[:stream_id])

    render json: @stream.commits
  end

  api :DELETE, '/api/v1/commits/:commit_id', 'Delete commit'
  def destroy
    Commit.find(params[:commit_id]).destroy
    head :no_content
  end

  api :GET, '/api/v1/commits/:commit_id', 'Show commit'
  def show
    @commit = Commit.find(params[:commit_id])

    render json: @commit
  end

  private

  def commit_param
    params.require(:commit).permit(:name, :path)
  end

end