class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |col|
      col.string :username
      col.string :password_digest
      col.string :email
      col.timestamps null: false
    end
  end
end
