require 'pry'
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

  get '/signup' do
   if logged_in?
     redirect to "/tweets"
   else
      erb :signup
    end
  end

  post '/signup' do
    if params[:username] != "" && params[:email] != "" && params[:password] != ""
    @user = User.create(username: params[:username], email: params[:email], password: params[:password])
    session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect "/signup"
    end
  end


  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/login'
    end
  end


  post '/login' do
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"

    else
      redirect "/login"
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect "/login"
    else
      redirect "/"
    end
  end



  helpers do

   def logged_in?
     !!current_user
   end


   def current_user
     @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
     end
   end


end
