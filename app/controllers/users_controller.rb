class UsersController < ApplicationController

  configure do
    enable :sessions 
    # unless test?
    set :session_secret, "secret"
  end

  get '/signup' do
    # binding.pry
    if Helpers.is_logged_in?(session)
      redirect to("/tweets")
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    # user signs up, if params are not empty, create a new user and set session id, redirect to index.
    # binding.pry
    if params[:username] != "" && params[:email] != "" && params[:password] != "" 
      @user = User.create(username: params[:username], email: params[:email], password_digest: params[:password])
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
    # binding.pry
    @user = User.find_by(params[:id])
    session[:user_id] = @user.id
    redirect to("/tweets")
  end
    
  get '/logout' do
    # binding.pry
    if Helpers.is_logged_in?(session)
      session.clear
      redirect to("/login")
    else
      redirect to("/")
    end
  end

  # post '/logout' do
  #   # if logged in, lets user logout and redirect to login page
  #   if Helpers.is_logged_in?(session)
  #     session.clear
  #     redirect to("/login")
  #   else
  #     redirect to("/")
  #   end
  #   # if not logged in and user tries to access /logout
  #   # redirect to("/")
  #   # if not logged in and user tries to access /tweets
  #   # redirect to("/login")
  #   # if logged in
  #   # redirect to("/tweets")
  # end

  get '/users/:slug' do
    # shows all a single users tweets
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

end
