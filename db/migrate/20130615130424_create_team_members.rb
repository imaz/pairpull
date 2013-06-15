class CreateTeamMembers < ActiveRecord::Migration
  def change
    create_table :team_members do |t|
      t.references :user, null: false
      t.references :team, null: false

      t.timestamps
    end
    add_index :team_members, :user_id
    add_index :team_members, :team_id
    add_index :team_members, [:user_id, :team_id], unique: true
  end
end
