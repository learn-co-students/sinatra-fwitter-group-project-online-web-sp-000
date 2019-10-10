require './config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'

    enable :sessions
    set :session_secret, "secret"
  end


  get '/' do 
    "Welcome to Fwitter"
    erb :index
    # binding.pry
  end 

  helpers do 

      def current_user
        @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
      end 

      def logged_in?
        !!current_user
      end 



  end 

  # get '/signup' do
  #   redirect '/tweets'
  # end 

  # post '/signup' do 
  #   redirect '/tweets'
  # end 

end