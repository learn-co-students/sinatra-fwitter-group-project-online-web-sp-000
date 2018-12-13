require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions 
    set :session_secret, "fwitter_lab"
  end

  get '/' do
    erb :index
  end

  helpers do
    def current_user(session)
      User.find(session[:id])
    end

    def logged_in?
      !!session[:id]
    end
  end

end
