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

  def vote(options)
    question = Question.find(options.fetch('question_id'))
    question.update(score: question.score + 1)
  end
end
