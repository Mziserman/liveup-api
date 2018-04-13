class Stream < ApplicationRecord
  belongs_to :channel

  has_many :chat_messages
  has_many :questions
  has_many :likes
end
