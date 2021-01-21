require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions 
    set :session_secret, "secret"
  end

  get '/' do
    #Because there is a layout.erb file it will load around all other erbs
    #No other specification or code required except the yield command.
    erb :'index'
  end

  helpers do 
    def current_user
      @user ||= User.find(session[:user_id]) if session[:user_id]
    end 

    def logged_in? 
      !!current_user 
    end 
  end 
end
