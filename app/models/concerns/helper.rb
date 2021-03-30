require 'pry'
class Helpers < ActiveRecord::Base

  def self.is_logged_in?(argument)
    !!argument[:user_id]
  end

  def self.current_user(arg)
    User.find(arg[:user_id])
  end

end