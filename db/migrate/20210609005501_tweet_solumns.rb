class TweetSolumns < ActiveRecord::Migration[6.0]
  def change
    add_column :tweets, :user_id, :integer
    add_column :tweets, :created_at, :datetime, null: false
    add_column :tweets, :updated_at, :datetime, null: false
  end
end
