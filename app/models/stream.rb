class Stream < ApplicationRecord
  belongs_to :channel
  has_many :chat_messages
  has_one :share_file
end
