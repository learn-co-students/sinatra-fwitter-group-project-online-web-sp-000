require './config/environment'
# require 'sinatra-flash'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    register Sinatra::Flash
    set :session_secret, "my_secret_session"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :'index'
  end

  ##### HELPERS #####
  helpers do
    def current_user
        User.find_by(id: session[:user_id])
    end

    def logged_in?
      !!current_user
    end
  end
end
