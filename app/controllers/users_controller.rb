class UsersController < ApplicationController
  get '/signup' do
    if logged_in?
      redirect "/tweets"
    else
      erb :"/users/create_user"
    end
  end
  
  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect "/signup"
    else
      user = User.create(params)
      session[:user_id] = user.id
      redirect "/tweets"
    end
  end
  
  get '/login' do
    if logged_in?
      redirect "/tweets"
    else
      erb :"/users/login"
    end
  end
  
  post '/login' do
    user = User.find_by(:username => params[:username])
    
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end
  
  get '/logout' do
    session.clear
    redirect "/login"
	end
	
	get '/users/:slug' do
	  User.all.each{|user| @user = user if user.slug == params[:slug]}
	  @tweets = @user.tweets
	  erb :"/users/show"
	end
end