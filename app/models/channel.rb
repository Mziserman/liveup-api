class Channel < ApplicationRecord

  belongs_to :streamer, class_name: "User", foreign_key: :streamer_id

end
