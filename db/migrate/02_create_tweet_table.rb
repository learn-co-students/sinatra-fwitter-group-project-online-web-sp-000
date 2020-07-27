class CreateTweetTable < ActiveRecord::Migration[4.2]

  def change
    create_table :tweets do |t|
      t.string :content
    end
  end

end
