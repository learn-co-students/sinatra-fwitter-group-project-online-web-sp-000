require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "fwitter_secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  helpers do
    def current_user
      User.find_by(username:session[:username])
    end
    
    def logged_in?
      !!session[:username]
    end
  end
  
end
