class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one  :stripe_plan
  has_one  :stripe_product, through: :stripe_plan
  
  has_many :streams
  has_one  :stripe_product

  has_many :chat_messages
  has_many :questions
  has_many :answers

  has_many :question_votes
  has_many :upvoted_questions, through: :question_votes, source: :question

  has_many :answer_votes
  has_many :upvoted_answers, through: :answer_votes, source: :answer

  has_one :channel, foreign_key: :streamer_id
  has_many :streams, through: :channel

  has_many :follows, foreign_key: :follower_id, class_name: "Follow"
  has_many :followed_channels, through: :follows, source: :channel
  has_many :followed_streamers, through: :followed_channels, source: :streamer

  has_many :owned_stream_relations, class_name: "OwnedStream"
  has_many :owned_streams, through: :owned_stream_relations, source: :stream

  has_many :followeds, through: :channel, source: :follows
  has_many :followed_by, through: :followeds, source: :follower

  has_many :likes
  has_many :liked_streams, through: :likes, source: :stream

  def like_stream!(stream)
    likes.create stream: stream
  end

  def follow!(channel)
    follows.create channel: channel
  end

  def self.checkCustomer(user)
    if user.stripe_id
      Stripe::Customer.retrieve(user.stripe_id)
    else
      false
    end
  end

end
