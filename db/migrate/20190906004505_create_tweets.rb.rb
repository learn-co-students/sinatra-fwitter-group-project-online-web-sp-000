class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :post
      t.datetime :date_created
      t.belongs_to :user
    end
  end
end
