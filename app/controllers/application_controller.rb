require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions 
    set :session_secret, "the_secret"
  end
  
  get "/" do 
    erb :index 
  end 

	helpers do
  	def logged_in?
  	  current_user ? true : false 
  	end
  
  	def current_user
  		User.find_by(id: session[:user_id]) if session[:user_id] != nil 
  	end
  end

end
