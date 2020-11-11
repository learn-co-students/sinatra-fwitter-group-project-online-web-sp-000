class CreateTweets < ActiveRecord::Migration[4.2]
  def change
    create_table :tweets do |t|
      t.text :content
      t.integer :user_id
    end
  end
end
