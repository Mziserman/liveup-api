class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :streams

  has_many :following, foreign_key: :follower_id, class_name: "Follow"
  has_many :followed, foreign_key: :streamer_id, class_name: "Follow"

  has_many :followed_streamers, through: :following, source: :streamer
  has_many :followers, through: :followed, source: :follower
end
