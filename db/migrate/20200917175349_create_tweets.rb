class CreateTweets < ActiveRecord::Migration[6.0]
  def change
  	create_table :tweets do |t|
  		t.belongs_to :user
  		t.string :title
  		t.text	 :content
  	end  	
  end
end
