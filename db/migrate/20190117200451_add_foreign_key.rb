class AddForeignKey < ActiveRecord::Migration
  def change
    add_column :tweets, :foreign_key, :integer
    end
  end
end
