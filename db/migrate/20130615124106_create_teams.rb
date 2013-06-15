class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.integer :current_wish_id

      t.timestamps
    end
  end
end
