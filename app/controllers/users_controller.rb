class UsersController < ApplicationController

  get "/signup" do
    if logged_in?

      redirect to "/tweets"
    else
      erb :"users/create_user"
    end
  end

  get "/login" do
    erb :"users/login"
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
end
