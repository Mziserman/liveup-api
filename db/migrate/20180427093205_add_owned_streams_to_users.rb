class AddOwnedStreamsToUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :owned_streams do |t|
      t.references :user
      t.references :stream
    end
  end
end
