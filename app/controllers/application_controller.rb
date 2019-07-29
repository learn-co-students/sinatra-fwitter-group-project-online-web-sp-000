require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter-secret"
  end

  get '/' do
    erb :home
  end

  helpers do

    def logged_in?
      !!session[:user_id]
    end
    
    def login(uname, password)
      @user = User.find_by(username:uname)
      if @user && @user.authenticate(password)
        session[:user_id] = @user.id
      else 
        erb :'users/login'
      end
    end

    def logout
      session.clear
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
    
  end

end
