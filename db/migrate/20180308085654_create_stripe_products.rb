class CreateStripeProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :stripe_products do |t|
      
      t.string :name
      t.integer :price

      t.timestamps
    end
  end
end
