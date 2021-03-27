require 'pry'
class Helpers

  def self.is_logged_in?(argument)
    !!argument[:user_id]
  end

  def self.current_user(arg)
    User.find(arg[:user_id])
  end

end