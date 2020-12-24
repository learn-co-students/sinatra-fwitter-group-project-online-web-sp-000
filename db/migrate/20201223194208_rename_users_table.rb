class RenameUsersTable < ActiveRecord::Migration[6.0]
  def change
    rename_table :user, :users
  end
end
