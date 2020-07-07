class UsersController < ApplicationController
    enable :sessions
    set :session_secret, 'fwitter'
    set :public_folder, 'public'
    set :views, 'app/views'

  #loads the signup page + creates a new user
  get '/signup' do
    if logged_in?
      redirect '/tweets' 
    else
      erb :'users/create'
    end
  end

  post '/signup' do
    @user = User.new(params)
    if @user.save
      session[:id] = @user.id
      redirect to('/tweets')
    else
      redirect to('/signup')
    end
  end

  #loads the login page + logs in the user
    get '/login' do
      if logged_in?
        redirect to('tweets') 
      else  
        erb :'users/login'
      end
    end

    post '/login' do
      @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
        session[:id] = @user.id
        redirect to("/tweets")
      else
        erb :'users/login'
      end
    end

  #Logs out the user
  get '/logout' do
    if logged_in?
      session.clear
      redirect to('/login')
    else
      redirect to('/')
    end
  end

  #Displays individual user's tweets
  get '/users/:slug' do
    @tweet = Tweet.find_by(params[:id])
    @user = User.find_by_slug(params[:slug])
    erb :"tweets/tweets"
  end
end
