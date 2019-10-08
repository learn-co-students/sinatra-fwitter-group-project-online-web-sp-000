class Tweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :content
      t.integer :user_id
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end
end