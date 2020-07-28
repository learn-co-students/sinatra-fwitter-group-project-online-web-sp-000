require './config/environment'

class ApplicationController < Sinatra::Base
 
  
  configure do
    
   
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do 
    erb :homepage
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
    
    def redirect_if_not_logged_in(proc)
      if !logged_in?
        redirect "/login"
      else
        proc.call
      end
    end

  end

end
