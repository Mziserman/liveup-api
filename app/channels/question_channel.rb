class QuestionChannel < ApplicationCable::Channel
  def subscribed
    channel = "stream_#{params[:stream_id]}_question_channel"
    stream_from channel
  end

  def unsubscribed; end

  def create(options)
    Question.create(
      content: options.fetch('content'),
      stream_id: params[:stream_id],
      user: current_user
    )
  end
end
