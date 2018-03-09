class Stream < ApplicationRecord
  has_one :user, as: :streamer

  has_many :subscriptions
  has_many :subscribers, through: :subscriptions, source: :user
end
