require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions #unless test?
    set :session_secret, "password_security"
  end

  get '/' do

    erb :"index"
  end

  helpers do
    def current_user(session) 
      # binding.pry
      @user = User.find_by_id(session[:user_id])
    end
  
    def is_logged_in?(session)
      # binding.pry
      !!session[:user_id]
    end
  end
end
