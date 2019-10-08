require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :views, "app/views"
    set :public_folder, 'public'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    if is_logged_in?
      erb :'/index'
    else
      erb :'/signup'
    end
  end

  helpers do

    def is_logged_in?
      !!current_user
    end
  
    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
  end
end
