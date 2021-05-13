class UsersController < ApplicationController

  configure do
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    if session[:user_id]
      erb :'tweets'
    else
      erb :'homepage'
    end
  end
  
  get '/login' do
    erb :'users/login'
  end
  
  get '/signup' do
    if session[:user_id]
      redirect '/tweets'
    else
      erb :'users/signup'
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
  
end
