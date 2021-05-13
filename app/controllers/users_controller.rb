class UsersController < ApplicationController

  configure do
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    if session[:user_id]
      erb :'tweets/index'
    else
      erb :'homepage'
    end
  end
  
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    if @user
      erb :'users/show'
    else
      erb :'homepage'
    end
  end
  
  
  get '/login' do
    if session[:user_id]
      redirect '/tweets'
    else
      erb :'users/login'
    end
  end
  
  get '/signup' do
    if session[:user_id]
      redirect '/tweets'
    else
      erb :'users/signup'
    end
  end
  
  get '/logout' do
    if session[:user_id]
      session.clear
      redirect '/login'
    else
      redirect '/tweets'
    end
  end
  
  post '/signup' do
    if params[:username] == "" || params[:password] == ""  || 
      params[:email] == "" 
      redirect '/signup'
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id
    
      redirect '/tweets'
    end
  end
  
  post "/login" do
    user = User.find_by(:username => params[:username])
	   
		if user && user.authenticate(params[:password])
		  session[:user_id] = user.id
		  redirect "/tweets"
		else
		  redirect "/login"
		end
  end
  
end