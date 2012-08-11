class CreateUserFuns < ActiveRecord::Migration
  def change
    create_table :user_funs do |t|
      t.integer :user_id
      t.integer :fun_id

      t.timestamps
    end
  end
end
