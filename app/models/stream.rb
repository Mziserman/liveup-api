class Stream < ApplicationRecord
  after_update :create_archive

  def create_archive
    if saved_change_to_live? && live
      opentok = OpenTok::OpenTok.new ENV["tokbox_api_key"], ENV["tokbox_api_secret"]
      archive = opentok.archives.create session_id, {
        resolution: "1280x720",
        name: title
      }
    end
  end

  default_scope { order(created_at: :desc) }

  belongs_to :channel

  has_many :chat_messages
  has_one :shared_file
  has_many :commits, through: :shared_file
  has_many :questions

  has_many :likes
  has_many :liked_by, through: :likes, source: :user
end
