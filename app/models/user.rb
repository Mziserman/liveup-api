class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :stripe_products

  has_many :chat_messages
  has_many :questions

  has_many :question_votes
  has_many :upvoted_questions, through: :question_votes, source: :question

  has_one :channel, foreign_key: :streamer_id
  has_many :streams, through: :channel

  has_many :follows, foreign_key: :follower_id, class_name: "Follow"
  has_many :followed_channels, through: :follows, source: :channel
  has_many :followed_streamers, through: :followed_channels, source: :streamer

  has_many :followeds, through: :channel, source: :follows
  has_many :followed_by, through: :followeds, source: :follower

  def follow!(channel)
    follows.create channel: channel
  end
end
