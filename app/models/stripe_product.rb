class StripeProduct < ApplicationRecord

  has_many :stripe_plans
  belongs_to :user

end
