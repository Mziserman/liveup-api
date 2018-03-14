class AddColumnsToStripePlan < ActiveRecord::Migration[5.1]
  def change
    add_column :stripe_plans, :streamer_id, :integer, index: true
    add_column :stripe_plans, :sbscriber_id, :integer, index: true
  end
end
