class Api::V1::CommitsController < ApplicationController
  
  before_action :authenticate_request!, except: [:index, :show]

  api :POST, '/api/v1/share_files/:share_files_id/commits', 'Create commit'
  param :commit, String, 'Commit object contain the following arguments'
  param :name, String, 'Name of commit'
  param :path, String, 'Path of file'
  def create
    file = ShareFile.find(params[:share_file_id])

    @commit = Commit.new(params.require(:commit).permit(:name, :path))

    @commit.version = file.commits.last.version + 1

    file.commits << @commit

    if @commit.save
      render json: @commit
    end

  end

  api :PUT, '/api/v1/commits/:commit_id', 'Update commit'
  param :commit, String, 'Commit object contain the following arguments'
  param :name, String, 'Name of commit'
  def update

    @commit = Commit.find(params[:commit_id])

    if @commit.update(params.require(:commit).permit(:name))
      render json: @commit
    else
      render json: @commit.errors, head: :unprocessable_entity
    end

  end

  api :GET, '/api/v1/streams/:stream_id/commits', 'Show all commits for a stream'
  def index
    @stream = Stream.find(params[:stream_id])

    render json: @stream.share_file.commits
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

end