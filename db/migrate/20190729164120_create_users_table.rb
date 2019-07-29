class CreateUsersTable < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
    end
  end
end


# Users should have a username, email, and password, and have many tweets.
# 
