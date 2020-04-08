require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions  
    set :session_secret, "fwitter_password"
  end
  

  get '/' do
    if logged_in?
      redirect '/tweets'
    else
  	 erb :index
    end
  end

  helpers do

  	def logged_in?
  		!!session[:user_id]
  	end

  	def current_user
  		@user = User.find(session[:user_id])
  	end

  	def logout!
  		session.clear
  	end

  end

end
