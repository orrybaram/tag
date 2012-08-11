class CreateMusics < ActiveRecord::Migration
  def change
    create_table :musics do |t|
      t.string :name
      t.string :artist
      t.integer :popularity
      t.integer :user_id

      t.timestamps
    end
  end
end
