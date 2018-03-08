class CreateStripePlan < ActiveRecord::Migration[5.1]
  def change
    create_table :stripe_plans do |t|
      t.belongs_to :user, index: true
      t.belongs_to :stripe_product, index: true

      t.string :stripe_id
    end
  end
end
