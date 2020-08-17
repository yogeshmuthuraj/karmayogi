class AddDefaultValueToBuddy < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :buddy, :boolean, default: false
  end

  def down
    change_column :users, :buddy, :boolean, default: nil
  end
end
