class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/signup'
    end
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect '/signup'
    else
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect '/tweets'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      session.clear
      redirect '/login'
    end
  end

  get '/logout' do
    if logged_in?
      # erb :'/users/logout'
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  # post '/logout' do
  #   session.clear
  #   redirect '/login'
  # end

  get '/users/:slug' do
    @user = User.find_by(params[:slug])
    erb :'/users/show_tweets'
  end
end
