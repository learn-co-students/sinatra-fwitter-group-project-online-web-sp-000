class UpdateUsers < ActiveRecord::Migration[4.2]
  rename_column :users, :name, :username
end
