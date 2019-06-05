require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  def current_user(session)
    if session[:user_id] != nil
      @current_user = User.find(session[:user_id])
    end
  end

  def logged_in?(session)
    
    !!session[:user_id]
  end



  get '/' do

  erb :index
  end

end
