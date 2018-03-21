class CreateSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions do |t|

      t.references :users
      t.references :channels
      t.string :stripe_plan_id

      t.timestamps
    end
  end
end
