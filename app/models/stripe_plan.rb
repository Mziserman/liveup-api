class StripePlan < ApplicationRecord

  belongs_to :user
  belongs_to :stripe_product

end
