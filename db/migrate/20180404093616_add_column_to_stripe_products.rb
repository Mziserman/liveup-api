class AddColumnToStripeProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :stripe_products, :slug, :string
    add_column :stripe_products, :product_type, :int
    add_column :stripe_products, :stripe_id, :string
  end
end
