class CreateTweet < ActiveRecord::Migration[6.0]
  def change
    create_table :tweet do |t|
      t.string :content 
      t.string :user_id
    end 
  end
end
