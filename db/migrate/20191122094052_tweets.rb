class Tweets < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets do |t|
      t.string :content
    end
  end
end
