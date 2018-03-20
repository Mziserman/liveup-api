class CreateChannels < ActiveRecord::Migration[5.1]
  def change
    create_table :channels do |t|

      t.string :name
      t.references :streamer

      t.timestamps
    end
  end
end
