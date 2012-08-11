class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :salt
      t.string :hashed_password
      t.string :active_code
      t.string :firstname
      t.string :lastname
      t.string :gender
      t.string :email
      t.string :email_parent
      t.integer :pe_class_id

      t.timestamps
    end
  end
end
