require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security_whatever"
  end

  get '/' do
    if logged_in?
      erb :index
    else
      erb :'/users/login'
    end
  end

  helpers do
    def current_user
      @current_user ||= User.find(session[:id]) if session[:id]
    end

    def logged_in?
      !!self.current_user
    end
  end

end
