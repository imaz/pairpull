class CreateTeamRequests < ActiveRecord::Migration
  def change
    create_table :team_requests do |t|
      t.integer :requestor_id, null: false
      t.integer :receptor_id, null: false
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
