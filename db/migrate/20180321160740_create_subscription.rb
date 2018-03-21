class CreateSubscription < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions do |t|

      t.references :users
      t.references :channel
      t.string :stripe_channel_id

    end
  end
end
