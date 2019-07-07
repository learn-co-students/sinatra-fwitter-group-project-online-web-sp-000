require './config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    enable :sessions
    set :session_secret, 'password privacy'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    end
    erb :signup
  end

  post '/signup' do
    user = User.new
    user.username = params[:username]
    user.email = params[:email]
    user.password = params[:password]
    if (params[:username] == "" || params[:email] == "" || params[:password] == "")
      redirect '/signup'
    else
      user.save
      session[:user_id] = user.id
      redirect "/tweets"
    end
  end

  get '/login' do
    erb :login
  end


  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

end
