class CreateTweets < ActiveRecord::Migration
  create_table :tweets do |t|
    t.string :content
    t.references :user, index: true, foreign_key: true
  end
end
