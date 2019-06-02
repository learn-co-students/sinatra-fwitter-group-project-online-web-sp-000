class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'users/create_user'
    end
  end
  
  post '/signup' do
    if params["username"] == "" || params["email"] == "" || params["password"] == ""
      redirect '/signup'
    end
    
    user = User.create(params)
    session[:user_id] = user.id
    #binding.pry
    redirect '/tweets'
  end
  
  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'users/login'
    end
  end
  
  post '/login' do
    user = User.find_by(username: params["username"])
    
    if user && user.authenticate(params["password"])
      session[:user_id] = user.id
      redirect '/tweets'
    end
    redirect '/login'
  end
  
  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end
  
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    
    erb :'users/show'
  end
end
