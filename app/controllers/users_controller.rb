class UsersController < ApplicationController

  get '/signup' do
    erb :'/users/signup'
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
    erb :'/users/login'
  end

  post '/login' do # creating a session, adding key/value pair to session hash
    @user = User.find_by(username: params[:username])
    if @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/tweets/index"
    else
      redirect '/users/login'
    end
  end

  get '/users/:id' do
    @user = User.find_by(id: params[:id])
    erb :'/users/show'
  end

  get '/logout' do
    redirect '/users/login'
  end
end
