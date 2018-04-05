class AddColumnToStripeProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :stripe_products, :slug, :string
  end
end
