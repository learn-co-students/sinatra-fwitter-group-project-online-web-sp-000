require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    erb :index
  end

  class Helpers
    def self.current_user(session)
      User.find_by_id(session[:user_id])
    end

    def self.is_logged_in?(session)
      !!session[:user_id]
    end
  end

end
