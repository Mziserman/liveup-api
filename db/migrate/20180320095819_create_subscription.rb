class CreateSubscription < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions do |t|

      t.references :stripe_product, foreign_key: true

      t.references :channel
      t.references :subscriber

      t.timestamps
    end
  end
end
