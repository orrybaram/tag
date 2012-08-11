class CreatePeClasses < ActiveRecord::Migration
  def change
    create_table :pe_classes do |t|
      t.string :name
      t.timestamps :datetime
      t.integer :school_id
      t.integer :teacher_id

      t.timestamps
    end
  end
end
