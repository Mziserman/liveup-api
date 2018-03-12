class Stream < ApplicationRecord
  belongs_to :streamer, foreign_key: :user_id, class_name: "User"

  has_many :follows
  has_many :followers, through: :follows, source: :user
end
