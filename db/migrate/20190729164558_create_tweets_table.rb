class CreateTweetsTable < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :content
      t.integer :user_id
    end
  end
end

# Tweets should have content and belong to a user.
#
