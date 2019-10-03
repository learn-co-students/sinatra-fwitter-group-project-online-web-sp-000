class UsersController < ApplicationController

  post "/signup" do
  if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
  @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
	  if @user.save
	      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  else
    redirect "/signup"
  end
  end
  
  post "/login" do
  @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
       redirect "/tweets"
    else
       redirect "/login"
    end
  end
  
  get "/users/:slug" do 
      @user = User.find_by_slug(params[:slug])
      erb :"/users/show"
  end    

 

end
