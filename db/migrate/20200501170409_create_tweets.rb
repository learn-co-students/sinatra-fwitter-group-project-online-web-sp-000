class CreateTweets < ActiveRecord::Migration[6.0]
  def change
    create_table :tweets do |x|
      x.string :content 
    end
  end
end
