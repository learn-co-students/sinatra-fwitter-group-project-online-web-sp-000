class RenameColumnTweet < ActiveRecord::Migration[6.0]
  def change
    rename_column :tweets, :tweet, :content
  end
end
