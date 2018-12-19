class UsersController < ApplicationController
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end
  
  get '/signup' do
    if logged_in?
      redirect :'/tweets'
    else
      erb :'users/signup'
    end
  end
  
  get '/login' do
    if logged_in?
      redirect :'/tweets'
    else
      erb :'users/login'
    end
  end
  
  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect :'/tweets'
    else
      redirect :'/login'
    end
  end
  
  post '/signup' do
    if params.values.any? { |value| value == "" }
      redirect :'/signup'
    else
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect :'/tweets'
    end
  end
  
  get '/logout' do
    if logged_in?
      session.clear
      redirect :'/'
    else
      redirect :'/login'
    end
  end
end
