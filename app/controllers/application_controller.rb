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

# helper methods to use across the controllers  
  helpers do
    def logged_in?
      !!current_user
    end
  
    def current_user
      current_user ||= User.find_by(id:session[:user_id]) if session[:user_id]
    end

    def redirect_if_not_logged_in
      if !logged_in?
        redirect '/login'
      end
    end

    def authorized_user?(tweet)
      tweet.user_id == current_user.id
    end

    def find_tweet
      @tweet = Tweet.find(params[:id])
    end
  end
end
