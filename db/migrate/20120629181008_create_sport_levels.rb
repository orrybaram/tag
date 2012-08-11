class CreateSportLevels < ActiveRecord::Migration
  def change
    create_table :sport_levels do |t|
      t.string :name
      t.string :guidence
      t.integer :sport_id

      t.timestamps
    end
  end
end
