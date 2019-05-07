require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  helpers do
    def valid_signup?
      if params[:username] != "" &&  params[:email] != "" && params[:password] != "" && params[:username] && params[:email] && params[:password]
        true
      else
        false
      end
    end

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      session[:username]
    end 
  end

end
