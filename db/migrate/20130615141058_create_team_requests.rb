class CreateTeamRequests < ActiveRecord::Migration
  def change
    create_table :team_requests do |t|
      t.references :users, null: false
      t.references :team, null: false
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :team_requests, :users_id
    add_index :team_requests, :team_id
  end
end
