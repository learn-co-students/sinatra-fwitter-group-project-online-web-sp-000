require './config/environment'

class ApplicationController < Sinatra::Base

#require 'securerandom'; puts SecureRandom.hex(64)

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter_secret"
  end

  get '/' do
    erb :index
  end
  #Home Page to /index; currently routing to layout.erb

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
    end
  end

end
