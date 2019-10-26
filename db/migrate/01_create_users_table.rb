class CreateUsersTable < ActiveRecord::Migration
  def change
    create_table :users do |u|
      u.string :username
      u.text :email
      u.string :password_digest
      u.timestamps null: false
    end
  end
end
