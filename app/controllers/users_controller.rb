require 'rack-flash'

class UsersController < ApplicationController
  use Rack::Flash

  get '/signup' do
    # binding.pry
    if is_logged_in?(session)
      flash[:message] = "You are already logged in."
      redirect '/tweets'
    end
      erb :"/users/signup"
  end

  post '/signup' do
    # binding.pry
    @user = User.create(params)
    if @user.id == nil 
      flash[:message] = "Invalid user credentials.  Please try again."
      redirect '/signup'
    else
      session[:user_id] = @user.id
      redirect "/tweets"
    end
  end

  get '/login' do
    if is_logged_in?(session)
      flash[:message] = "You are already logged in."
      redirect '/tweets'
    end
      erb :"/users/login"
  end
  
  post '/login' do
    # binding.pry
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id

      redirect "/tweets"
    else
      flash[:message] = "Incorrect login credentials.  Please try again."
      redirect "/login"
    end
  end

 

  get '/logout' do
    if is_logged_in?(session)
      session.clear
      redirect "/login"
    else
      redirect "/"
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    @tweets = @user.tweets
    erb :"/users/show"
  end 




end
