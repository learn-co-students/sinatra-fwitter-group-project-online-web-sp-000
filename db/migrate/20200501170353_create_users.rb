class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |x|
      x.string :username
      x.string :email 
      x.string :password_digest 
    end
  end
end
