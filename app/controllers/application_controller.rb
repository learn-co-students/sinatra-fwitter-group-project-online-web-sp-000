require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
  end

  get '/' do 
    erb :'/layout'
  end 

  helpers do 

    def current_user
      @user ||= User.find_by_id(session[:user_id]) if session[:user_id]
    end 
  
    def is_logged_in?
      !!current_user 
    end 

  end


end
