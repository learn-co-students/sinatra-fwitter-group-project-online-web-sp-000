require 'sinatra/base'

class Helpers

  def self.is_logged_in?(session)
    # binding.pry
    !!session[:user_id]
  end
  def self.current_user(session)
    User.find(session[:user_id])
  end
end
