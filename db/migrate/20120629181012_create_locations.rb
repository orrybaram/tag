class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.string :address
      t.float :longitude
      t.float :latitude
      t.string :gmaps

      t.timestamps
    end
  end
end
