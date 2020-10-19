class UsersController < ApplicationController

  get '/users/:id' do
    @user = User.find(params[:id])
    erb :'/users/show'
  end

  get '/signup' do
    redirect "/tweets" if logged_in?
    erb :'/users/create_user'
  end 

  post '/signup' do
    redirect '/signup' if params[:username] == '' || params[:email] == '' || params[:password] == ''
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    @user.save
    session[:user_id] = @user.id
    redirect '/tweets'
  end

  get '/login' do
    redirect '/tweets' if logged_in?
    erb :'/users/login'
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect '/signup'
    end 
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/users/login'
    else
      redirect '/'
    end 
  end 

end
