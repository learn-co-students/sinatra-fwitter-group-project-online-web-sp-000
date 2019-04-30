require 'pry'
class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect "/tweets"
    else
      erb :'/users/create_user'
    end
  end

  get '/login' do
    if logged_in?
      redirect "/tweets"
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    if @user = User.find_by(username: params[:username])
      if @user.authenticate(params[:password])
        login(@user.id)
        redirect "/tweets"
      end
    else
      redirect "/signup"
    end
  end

  post '/signup' do
    if params.values.any? { |v| v == "" }
      redirect "/signup"
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      @user.save
      login(@user.id)
      redirect "/tweets"
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

  get '/logout' do
    if logged_in?
      @user = User.find_by(id: session[:user_id])
      session.destroy
      redirect "/login"
    else
      redirect "/"
    end
  end
end
