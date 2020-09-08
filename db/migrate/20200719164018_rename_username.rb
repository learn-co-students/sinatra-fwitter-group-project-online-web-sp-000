class RenameUsername < ActiveRecord::Migration[6.0]
  def change
    change_table :users do |t|
      t.rename :user_name, :username
    end
  end
end
