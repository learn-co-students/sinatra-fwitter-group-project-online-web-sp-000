class UsersController < ApplicationController

  get '/signup' do
    if is_logged_in?(session)
      redirect "/tweets"
    else
      erb :'users/signup'
    end
  end

  post '/signup' do
    @user = User.new(params)

    if @user.save
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      session[:error_message] = "Error: You must fill out a username, email, and password to sign up."
      redirect "/signup"
    end
  end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do
    @user = User.find_by(username: params[:user][:username])

    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/error"
    end
  end

  get '/logout' do
    session.clear
    redirect "/login"
  end

  helpers do

    def is_logged_in?(session)
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

  end

end
