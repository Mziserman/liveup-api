class Like < ApplicationRecord
  validates :user, uniqueness: { scope: :stream }

  belongs_to :stream, counter_cache: true
  belongs_to :user
end
