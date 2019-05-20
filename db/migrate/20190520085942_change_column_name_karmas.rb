class ChangeColumnNameKarmas < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :karmas, :karma
  end
end
