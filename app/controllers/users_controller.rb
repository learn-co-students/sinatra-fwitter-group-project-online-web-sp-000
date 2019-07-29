class UsersController < ApplicationController

  get "/users/:slug" do

    @user = User.find_by_slug(params[:slug])
    erb :"users/show"

  end
  get "/signup" do
    if Helpers.logged_in?(session)
      redirect to "/tweets"
    else
      erb :"users/create_user"
    end
  end

  get "/login" do
    if Helpers.logged_in?(session)
      redirect to "/tweets"
    else
      erb :"users/login"
    end
  end

  get "/logout" do
    session.clear
    redirect to "/login"
  end

  post "/signup" do
    user = User.new(:username => params[:username], :password => params[:password], :email => params[:email])
    if user.save
      session[:user_id] = user.id
      redirect to "/tweets"
    else
      redirect to "/signup"
    end
    # redirect to "/tweets"
  end

  post "/login" do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/tweets"
    else
      redirect to "/login"
    end
  end
end
