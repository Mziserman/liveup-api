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
    if current_user.upvoted_questions.include?(question)
      question_vote = QuestionVote.find user: current_user, question: question
      question_vote.destroy
    else
      question_vote = QuestionVote.create user: current_user, question: question
    end
  end
end
