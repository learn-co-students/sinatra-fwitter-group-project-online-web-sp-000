class CreateTweets < ActiveRecord::Migration[6.0]
  def change
    create_table :tweets do |col|
      col.string :content
      col.integer :user_id
      col.timestamps null: false
    end
  end
end
