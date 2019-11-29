require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  # HOME PAGE
  get '/' do

    erb :index
  end

  helpers do
    def logged_in?
      !!session[:id]
    end

    def current_user
      User.find(session[:id])
    end

    def find_tweet
        Tweet.find(params[:id])
    end

    def belongs_to_user?(tweet)
        tweet.user == current_user
    end

  end

end
