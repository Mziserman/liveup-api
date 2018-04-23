class Stream < ApplicationRecord
  belongs_to :channel

  has_many :chat_messages
  has_one :shared_file
  has_many :commits, through: :shared_file
  has_many :questions

  has_many :likes
  has_many :liked_by, through: :likes, source: :user
end
