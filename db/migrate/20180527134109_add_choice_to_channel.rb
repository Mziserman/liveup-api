class AddChoiceToChannel < ActiveRecord::Migration[5.1]
  def change
    add_column :channels, :channel_type, :integer, default: 0
    add_column :channels, :aws_channel_id, :string, null: true
    add_column :channels, :aws_input_id, :string, null: true

    add_column :streams, :state, :integer, default: 0
    add_column :streams, :output_stream_url, :string, null: true
    add_column :streams, :input_stream_url, :string, null: true
  end
end
