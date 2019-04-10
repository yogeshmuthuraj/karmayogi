class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :team_id
      t.string :name
      t.string :user_id
      t.integer :karmas

      t.timestamps
    end
    add_index :users, :team_id, unique: true
    add_index :users, :user_id, unique: true
  end
end
