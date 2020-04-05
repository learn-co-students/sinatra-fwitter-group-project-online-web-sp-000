require 'pry'
class UsersController < ApplicationController

  get '/signup' do
    redirect "/tweets" if logged_in?
    erb :'users/signup'
  end

  post '/signup' do
    redirect "/signup" if params[:username] == "" || params[:email] =="" || params[:password] == ""
    user = User.create(params)
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    redirect '/tweets' if logged_in?
    erb :'users/login'
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'tweets/show'
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end

end
