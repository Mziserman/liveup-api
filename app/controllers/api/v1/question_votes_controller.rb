class Api::V1::QuestionsController < ApplicationController
  before_action :authenticate_request!
  before_action :set_stream

  api :GET, '/v1/streams/:id/question_votes', 'Question index'
  def index
    @upvoted_questions = @current_user.upvoted_questions.where(stream: @stream)
    render json: @upvoted_questions,
      status: :ok
  end

  private

  def set_stream
    @stream = Stream.find(params[:stream_id])
  end

end
