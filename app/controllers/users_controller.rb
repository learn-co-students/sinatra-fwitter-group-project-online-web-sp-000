class UsersController < ApplicationController
  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/create_user'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/signup' do
    if params[:username].blank? || params[:password].blank? || params[:email].blank?
      redirect '/signup'
    else
      @user = User.create(username: params[:username], password: params[:password], email: params[:email])
      session[:user_id] = @user.id
      redirect '/tweets'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end
end