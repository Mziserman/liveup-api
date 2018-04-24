class CreateInterestedUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :interested_users do |t|
      t.text :email
    end
  end
end
