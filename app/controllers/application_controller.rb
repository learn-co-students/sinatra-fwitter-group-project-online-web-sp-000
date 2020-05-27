require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "appfortwits"
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  
  get '/' do
    erb :index
  end

  # helper methods ##############################
  def signup_login(username, email, password)
    if username == "" || email == "" || password == ""
      redirect '/signup'
    else
      user = User.find_by(username: username)
    end
  
    if user && user.authenticate(password)
      session[:user_id] = user.id
    else
      redirect '/signup'
    end
  end
  
  def login(username, password)
    if username == "" || password == ""
      redirect '/login'
    else
      user = User.find_by(username: username)
    end
  
    if user && user.authenticate(password)
      session[:user_id] = user.id
    else
      redirect '/signup'
    end
  end

  def current_user
    User.find(session[:user_id])
  end
  
  def logged_in?
    !!session[:user_id]
  end
end
