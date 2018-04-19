class QuestionChannel < ApplicationCable::Channel
  def subscribed
    channel = "stream_#{params[:stream_id]}_question_channel"
    stream_from channel
  end

  def unsubscribed; end

  def question(options)
    Question.create(
      content: options.fetch('content'),
      stream_id: params[:stream_id],
      user: current_user
    )
  end

  def answer(options)
    Answer.create(
      content: options.fetch('content'),
      question_id: options.fetch('question_id'),
      stream_id: params[:stream_id],
      user: current_user
    )
  end

  def vote_answer(options)
    answer = Answer.find(options.fetch('answer_id'))
    if current_user.upvoted_answers.include?(answer)
      answer_vote = AnswerVote.find_by user: current_user, answer: answer
      answer_vote.destroy
    else
      answer_vote = AnswerVote.create user: current_user, answer: answer
    end
  end

  def vote_question(options)
    question = Question.find(options.fetch('question_id'))
    if current_user.upvoted_questions.include?(question)
      question_vote = QuestionVote.find_by user: current_user, question: question
      question_vote.destroy
    else
      question_vote = QuestionVote.create user: current_user, question: question
    end
  end
end
