class Channel < ApplicationRecord
  validates :name, uniqueness: true
  validates :name, presence: true
  validates :slug, uniqueness: true
  validates :slug, presence: true

  belongs_to :streamer, class_name: "User"
  has_many :streams
  has_many :follows

  before_validation :set_slug

  def set_slug
    self.slug = name.parameterize
  end
end
