class UsersController < ApplicationController
  
  get "/signup" do
    if session[:user_id]
      redirect "/tweets"
    else
      erb :'users/signup'
    end
  end
  
  post "/signup" do
    if params[:username].empty? || params[:password].empty? || params[:email].empty?
      redirect "/signup"
    else
       @user = User.create(username: params[:username], password: params[:password], email: params[:email])
      session[:user_id] = @user.id
      redirect "/tweets"
    end
  end
  
  get "/login" do
    if session[:user_id]
      redirect "/tweets"
    else
      erb :'/users/login'
    end
  end
  
  post "/login" do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/tweets"
    end
  end
  
  get "/logout" do
    if session[:user_id]
      session.clear
      redirect "/login"
    else
      redirect "/"
    end
  end
  
  get "/users/:slug" do
    @user = User.find_by(username: params[:slug].slug)
    erb :'/users/show'
  end

end
