class UsersController < ApplicationController

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])

    erb :'users/show'
  end

  get '/signup' do
    # if the user is already signed up, redirect to Tweets
    # if the user is not signed up- sign up, direct to create user form

    if logged_in?
      redirect '/tweets'

    else
      erb :'/users/signup'
    end
  end

  post '/signup' do
    # creates a new user if all credentials are provided
    # if credentials are blank, redirect to signup

    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect '/signup'

    else
      @user = User.new(params)
      @user.save
      session[:user_id] = @user.id

      redirect '/tweets'
    end
  end

  get '/login' do
    # if a user is already logged in, they will be redirected to Tweets page
    # if the user is not logged in, send them to the login page (maybe use an error message)

    if logged_in?

      redirect '/tweets'

    else
      erb :'/users/login'
    end
  end

  post '/login' do
    # find user, authenticate user, create session for logged in user
    # if logged in redirect to Tweets
    # if not logged in redirect to login page

    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id

      redirect '/tweets'

    else
      redirect '/login'
    end
  end

  get '/logout' do

    if logged_in?
      session.clear

      redirect '/login'

    else
      redirect '/'
    end
  end


end
