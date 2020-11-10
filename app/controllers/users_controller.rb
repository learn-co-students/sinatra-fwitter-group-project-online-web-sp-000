require "pry"

class UsersController < ApplicationController
  get "/signup" do
    if logged_in? == false
      erb :'/users/signup'
    end
  end

  post "/signup" do
    if params[:username] != "" && params[:email] != "" && params[:password] != ""
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      redirect "tweets/index"
    else
      if logged_in? == false
        redirect to "/signup"
      end
    end
  end

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

  get "/login" do
    if logged_in? == false
      erb :'/users/login'
    else
      erb :'/tweets/index'
    end
  end

  post "/login" do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
    end
    redirect "/tweets/index"
  end

  get "/logout" do
    session.clear
    redirect "users/login"
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
