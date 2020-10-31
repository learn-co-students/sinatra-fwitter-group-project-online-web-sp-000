require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    "Welcome to Fwitter"
    # erb :index
  end

  # get '/signup' do
  #   if !logged_in?
  #     redirect '/tweets'
  #   else
  #     erb :'users/create_user'
  #   end
  # end

  # helpers do

  #   def logged_in?
  #     !!current_user
  #   end
    
  #   def current_user
  #     User.find_by(id: session[:user_id])
  #   end

  #   def authenticate
  #     redirect '/login' if !logged_in?
  #   end

  #   def authorize(tweet)
  #     authenticate
  #     if tweet.user != current_user
  #       redirect '/tweets'
  #     end
  #   end
  # end

  

end
