class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :user_id
      t.integer :event_id
      t.integer :initial_level_id   
      t.integer :sport_level_id

      t.timestamps
    end
  end
end
