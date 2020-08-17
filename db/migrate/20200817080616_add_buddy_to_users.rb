class AddBuddyToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :buddy, :boolean
  end
end
