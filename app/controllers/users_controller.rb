class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect "/tweets/index"
    else
      erb :'/users/signup'
    end
  end

  post '/signup' do
    if params[:username] != "" && params[:email] != "" && params[:password] != ""
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect "/tweets/#{@user.id}"
    else
      redirect '/users/signup'
    end
  end

  get '/login' do
    if logged_in?
      redirect "/tweets/index"
    else
      erb :'/users/login'
    end
  end

  post '/login' do # creating a session, adding key/value pair to session hash
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
      # redirect "/tweets/#{@user.id}"
    else
      redirect '/users/login'
    end
  end

  get '/users/:id' do
    @user = User.find_by(id: params[:id])
    erb :'/users/show'
  end

  get '/logout' do
    session.clear
    redirect '/users/login'
  end
end
