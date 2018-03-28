class CreateChannels < ActiveRecord::Migration[5.1]
  def change
    create_table :channels do |t|

      t.string :name
      t.references :streamer

      t.timestamps
    end

    remove_reference :follows, :streamer
    add_reference :follows, :channel
    add_reference :streams, :channel
  end
end
