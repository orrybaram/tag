class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :sport_id
      t.datetime :datetime
      t.integer :location_id
      t.integer :teacher_id
      t.integer :tainer_id
      t.integer :user_id
      t.integer :pe_class_id

      t.timestamps
    end
  end
end
