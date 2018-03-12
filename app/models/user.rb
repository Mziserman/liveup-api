class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :stripe_products
  has_many :streams

  has_many :follows
  has_many :followed_streams, through: :follows, source: :stream
  has_many :followed_streamers, through: :followed_streams, source: :streamer
end
