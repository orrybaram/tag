class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :firstname
      t.string :lastname
      t.string :sex
      t.string :email
      t.string :telephone
      t.integer:school_id
      t.string :salt
      t.string :hashed_password
      t.string :active_code

      t.timestamps
    end
  end
end
