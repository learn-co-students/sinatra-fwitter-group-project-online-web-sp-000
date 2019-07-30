class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :name
      t.string :password_digest
      t.string :user_name, index: true
    end
  end
 
  def down
    drop_table :users
  end
end
