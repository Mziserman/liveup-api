class Stream < ApplicationRecord
  enum state: { creating: 0, live: 1, off: 2, rediffusion: 3 }

  belongs_to :channel

  has_many :chat_messages
  has_one :shared_file
  has_many :commits, through: :shared_file
  has_many :questions

  has_many :view_counts

  has_many :likes
  has_many :liked_by, through: :likes, source: :user

  default_scope { order(created_at: :desc) }

  def view_count
    view_counts&.last&.count || 0
  end

  def total_view_count
    view_counts&.last&.total_count || 0
  end

  after_create_commit :create_view_count
  def create_view_count
    view_counts.create
  end


  after_update :change_state
  def change_state
    if saved_change_to_archive_url? && saved_change_to_thumbnail? &&
      self.archive_url.present? && self.thumbnail.present?
      self.state = :rediffusion
      self.save
    end
  end

  after_update :broadcast_state
  def broadcast_state
    if saved_change_to_state?
      ActionCable
        .server
        .broadcast("stream_#{id}_state_channel",
          state: state)
    end
  end

end
