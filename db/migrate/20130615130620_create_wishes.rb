class CreateWishes < ActiveRecord::Migration
  def change
    create_table :wishes do |t|
      t.references :team
      t.string :title
      t.boolean :done, default: false

      t.timestamps
    end
    add_index :wishes, :team_id
  end
end
