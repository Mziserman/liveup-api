class StripeProduct < ApplicationRecord
  validates :name, uniqueness: true
  validates :name, presence: true

  before_create :set_slug

  has_many :stripe_plans

  private
  
  def set_slug
    self.slug = name.parameterize
  end

end
