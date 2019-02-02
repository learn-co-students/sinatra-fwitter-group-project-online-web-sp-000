require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do 
    erb :index
  end

  def logged_in?
    if session[:user_id]
      true
    else
      false
    end
  end

  def current_user
    return User.find(session[:user_id])
  end

end
