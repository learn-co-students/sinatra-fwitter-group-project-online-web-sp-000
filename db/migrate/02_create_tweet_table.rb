# frozen_string_literal: true

# Migration creating Tweet table using Active Record
class CreateTweetTable < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets do |t|
      t.text :content, null: false
      t.integer :user_id, null: false
      t.timestamps
    end
  end
end