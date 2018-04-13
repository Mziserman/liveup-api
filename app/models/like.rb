class Like < ApplicationRecord
  validates :user, uniqueness: { scope: :stream }

  belongs_to :stream
  belongs_to :user
end
