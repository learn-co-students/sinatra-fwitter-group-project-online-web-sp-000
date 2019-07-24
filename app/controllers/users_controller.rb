class UsersController < ApplicationController

  get "/signup" do
    erb :'/users/create_user'
  end

  post "/signup" do
	@user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])

	  if @user.save && @user[:username] != ""
	    erb :"/tweets/tweets"
    end
  end






  get '/account' do
    @user = User.find(session[:user_id])
    erb :"/tweets/tweets"
  end


  get "/login" do
    erb :'/users/login'
  end

  post "/login" do
    user = User.find_by(:username => params[:username])
#binding.pry
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/account"
#    else
#      redirect "/failure"
    end
  end



end
