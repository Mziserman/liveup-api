class Api::V1::SubscriptionController < ApplicationController

  before_filter :authenticate_user!
  
  def create
  
    customer = checkCustomer(@current_user)

    product = StripeProduct.find(params[:id])

    plan = Stripe::Plan.create(
      :amount => product.price,
      :interval => "month",
      :currency => "eur",
      :product => {
        :name => "Subscription " + product.name
      }
    )

    @subscription = Subscription.new(
                      channel: product.user.channel,
                      user: @current_user,
                      stripe_plan_id: plan.id
                    )

    if @subscription.save
      render json: @subscription
    end

  end

  private

  def checkCustomer(user)
    if user.stripe_id
      return Stripe::Customer.retrieve(user.stripe_id)
    else
      customer = Stripe::Customer.create(:email => user.email)
      user.stripe_id = customer.id
      if user.save
        return customer
      end
    end

  end

end
