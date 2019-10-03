require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end
  
  get "/" do
    erb :index
  end

  get "/signup" do
    if !logged_in?
    erb :"users/create_user"
    else
    redirect "/tweets"
    end
  end
  
  get "/login" do
    if !logged_in?
    erb :"users/login"
    else
    redirect "/tweets"
    end
  end
  
  get "/logout" do
    if logged_in?
   session.clear
      redirect "/login"
    else 
      redirect "/"
    end
  end
  
  
  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end
  
end