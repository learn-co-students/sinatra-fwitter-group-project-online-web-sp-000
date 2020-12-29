class CreateTables < ActiveRecord::Migration[6.0]
  def up
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :email  
    end

    create_table :tweets do |t|
      t.string :content
      t.integer :user_id
    end
  end

  def down
    drop_table :users
    drop_table :tweets
  end
end
