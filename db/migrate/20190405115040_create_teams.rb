class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :team_id
      t.string :security_token

      t.timestamps
    end
  end
end
