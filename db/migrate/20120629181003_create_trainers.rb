class CreateTrainers < ActiveRecord::Migration
  def change
    create_table :trainers do |t|
      t.string :firstname
      t.string :lastname
      t.string :sex
      t.string :email
      t.integer :telephone  

      t.timestamps
    end
  end
end
