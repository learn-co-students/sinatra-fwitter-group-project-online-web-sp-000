class CreateUsers < ActiveRecord::Migration
#  raise 'Write CreateLandmarks migration here'

  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :password_digest
    end
  end
end
