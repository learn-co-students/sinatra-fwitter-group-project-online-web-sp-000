require './config/environment'
require "./app/models/user.rb"
require "./app/models/tweet.rb"

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'

    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do 
    erb :"/application/home"
  end

  helpers do 
    def is_logged_in?
        !!session[:user_id]
    end

    def current_user
        # returns user object 
        User.find(session[:user_id])
    end

    def is_authorized?(tweet)
        current_user.id == tweet.user_id
    end
  end 
end
