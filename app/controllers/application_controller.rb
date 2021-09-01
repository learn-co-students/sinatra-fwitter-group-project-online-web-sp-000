require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "my_application_secret"
  end

  get '/' do
    if logged_in?
      redirect to '/tweets'
    else 
      erb :index
    end 
  end

  helpers do 

    def logged_in?
      !!current_user
    end 

    def current_user
      User.find_by(id: session[:user_id]) if session[:user_id]
    end 
  
  end 

end
