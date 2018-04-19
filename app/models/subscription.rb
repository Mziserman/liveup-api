class Subscription < ApplicationRecord

  belongs_to :subscriber, class_name: "User", foreign_key: :subscriber_id
  belongs_to :channel, class_name: "Channel", foreign_key: :channel_id

end
