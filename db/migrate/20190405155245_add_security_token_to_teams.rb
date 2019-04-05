class AddSecurityTokenToTeams < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :security_token, :string
  end
end
