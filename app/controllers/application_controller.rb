require './config/environment'

#i don't know how to organise my methods...look at solution for answer. 

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter_app_security"
  end

  get '/' do 
    erb :index 
  end 

  get '/failure' do 
    erb :failure 
  end 

  helpers do 
    def logged_in?
      !!session[:user_id]
    end 

    def current_user
      User.find_by_id(session[:user_id])
    end 
  end 

end
