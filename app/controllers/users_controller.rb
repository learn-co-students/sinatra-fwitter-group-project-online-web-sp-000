class UsersController < ApplicationController

  configure do
    enable :sessions 
    # unless test?
    set :session_secret, "secret"
  end

  get '/signup' do
    if Helpers.is_logged_in?(session)
      redirect to("/tweets")
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    # user signs up, if params are not empty, create a new user and set session id, redirect to index.
    if params[:username] != "" && params[:email] != "" && params[:password] != "" 
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      redirect to("/tweets")
    else 
      redirect to ("/signup")
    end
  end
    
  get '/login' do
    # does not let the user view the login page if already logged in
    if Helpers.is_logged_in?(session)
      redirect to("/tweets")
    else
      erb :'/users/login'
    end
  end
    
  post '/login' do
    
    @user = User.find_by(username: params[:username])
    # binding.pry
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to("/tweets")
    else
      redirect to ("/login")
    end
  end
    
  get '/logout' do
    if Helpers.is_logged_in?(session)
      session.clear
      redirect to("/login")
    else
      redirect to("/")
    end
  end

  get '/users/:slug' do
    # shows all a single users tweets
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

end
