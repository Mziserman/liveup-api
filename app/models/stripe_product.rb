class StripeProduct < ApplicationRecord
  validates :name, uniqueness: true
  validates :name, presence: true

  before_create :init_stripe

  has_many :stripe_plans

  enum product_type: { reccurring: 0, one_shot: 1 }

  Stripe.api_key = ENV["stripe_api"]

  private
  
  def init_stripe
    self.slug = name.parameterize

    plan = Stripe::Plan.create({
      nickname: self.name + ' plan',
      interval: 'month',
      currency: 'eur',
      amount: self.price,
      product: {
        name: self.name + ' product'
      }
    })

    self.stripe_id = plan.id
  end

end
