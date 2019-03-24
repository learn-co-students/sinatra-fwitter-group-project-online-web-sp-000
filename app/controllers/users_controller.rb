require 'pry'

class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      # a user is already logged in. show his home page.
      redirect to '/tweets'
    end
    erb :'users/create_user'
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      # cannot have empty fields
      redirect to '/signup'
    end
    user = User.create(username: params[:username], email: params[:email], password: params[:password])
    session[:user_id] = user.id
    redirect to '/tweets'
  end

  get '/login' do
    if logged_in?
      redirect to '/tweets'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      # user is now logged in. Redirect to tweets.
      redirect to '/tweets'
    end
    # unable to login user. show login page again.
    erb :'users/login'
  end

  get '/logout' do
    session.clear
    redirect to "/login"
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
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
