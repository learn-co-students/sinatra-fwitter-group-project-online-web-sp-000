class CreateUsers < ActiveRecord::Migration[6.0]
  def up
    create_table :users do |t|
      t.string :email
      t.string :username
      t.string :password_digest

      t.timestamps null: false
    end
  end
  
  def down
    drop_table :users
  end
end
