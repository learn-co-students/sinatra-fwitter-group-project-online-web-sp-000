class UserTable < ActiveRecord::Migration[6.0]
  #username, email, password
  def change
    create_table :user do |t|
      t.string :username
      t.string :email
      t.string :password_digest
    end
  end
end
