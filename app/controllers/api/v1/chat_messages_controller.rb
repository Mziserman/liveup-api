class Api::V1::ChatMessagesController < ApplicationController
  before_action :set_stream

  api :GET, '/v1/streams/:id/chat_messages', 'ChatMessage index'
  def index
    @chat_messages = @stream.chat_messages.last(150)
    render json: @chat_messages
  end

  private

  def set_stream
    @stream = Stream.find(params[:stream_id])
  end

end
