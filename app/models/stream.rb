class Stream < ApplicationRecord
  belongs_to :channel
  has_many :chat_messages
end
