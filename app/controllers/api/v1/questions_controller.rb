class Api::V1::QuestionsController < ApplicationController
  before_action :set_stream

  api :GET, '/v1/streams/:id/questions', 'Question index'
  def index
    @questions = @stream.questions.first(50)
    render json: @questions
  end

  private

  def set_stream
    @stream = Stream.find(params[:stream_id])
  end

end
