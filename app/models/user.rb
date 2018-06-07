class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_base64_uploader :avatar, AvatarUploader

  validates :pseudo, uniqueness: true
  validates :pseudo, presence: true

  has_many :stripe_products

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

  has_many :followeds, through: :channel, source: :follows
  has_many :followed_by, through: :followeds, source: :follower

  has_many :likes
  has_many :liked_streams, through: :likes, source: :stream

  before_create :set_color
  def set_color
    self.color = ["#524c84", "#d65d7a", "#fff9af", "#92e6e6"].sample
  end

  def like_stream!(stream)
    likes.create stream: stream
  end

  def follow!(channel)
    follows.create channel: channel
  end
end
