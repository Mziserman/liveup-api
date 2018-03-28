class Channel < ApplicationRecord

  belongs_to :streamer, class_name: "User"
  has_many :streams

  has_many :follows

end
