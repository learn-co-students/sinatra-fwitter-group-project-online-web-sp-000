require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions 
    set :session_secret, "952c62e1ef1e90b73ede1b7b4a68a9ef5663120896559e0eecf8c759b627c06c2bb8ab0ed41877932f413a7aa34887b9f3cbd
    551852a6eefefb15e980de20e9e"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do 

    erb :'./index'
  end 

  helpers do 

    def logged_in? 
      !!current_user 
    end 

    def current_user 
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end 

    def login(username, password)
      # check if user with this email exists 
      # set the session if true 
      # redirect otherwise
      if user = User.find_by(username: username) && User.authenticate(password)
        session[:username] = user.username
      else  
        redirect to '/login'
      end 
    end 

    def logout 
      session.clear 
    end 
  end 
end
