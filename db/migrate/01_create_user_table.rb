#frozen_string_literal: true

# Migration creating users table using Active Record
class CreateUserTable < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.text :username, null: false
      t.text :email, null: false
      t.text :password_digest, null: false
      t.timestamps
    end
  end
end
