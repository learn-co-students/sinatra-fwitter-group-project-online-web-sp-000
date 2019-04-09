require 'pry'
class UsersController < ApplicationController

  get "/signup" do
    if logged_in?
      redirect "/tweets"
    else
      erb :signup
    end
  end

  post "/signup" do
    if params.none? {|param, value| value.empty?}
      user = User.new(:username => params[:username], :password => params[:password])
      if user.save
        session[:user_id] = user.id
        redirect "/tweets"
      end
    else
      redirect "/signup"
    end
  end

  get "/login" do
    if logged_in?
      redirect "/tweets"
    else
      erb :'/users/login'
    end
  end

  post "/login" do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect "failure"
    end
  end

  get "/success" do
    if logged_in?
      erb :success
    else
      redirect "/login"
    end
  end

  get "/failure" do
    erb :failure
  end

  get "/logout" do
    if logged_in?
      session.clear
      redirect "/login"
    else
      redirect "/"
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

end
