class CreateTweets < ActiveRecord::Migration[6.0]
  def change
    create_table :tweets do |t|
      t.string :content
<<<<<<< HEAD
      t.integer :user_id
=======
>>>>>>> 6ea8bbd313ce109bdb609a1d38672556da8704e2
    end
  end
end
