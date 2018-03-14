class Stream < ApplicationRecord
  belongs_to :streamer, foreign_key: :user_id, class_name: "User"
end
