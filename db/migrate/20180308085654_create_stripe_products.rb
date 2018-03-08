class CreateStripeProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :stripe_products do |t|
      t.belongs_to :user, index: true 

      t.string :stripe_id
      t.integer :price

      t.timestamps
    end
  end
end
