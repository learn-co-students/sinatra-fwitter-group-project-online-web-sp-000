class UsersController < ApplicationController

  get '/signup' do # signup link in home page
    erb :"/users/create_user"
  end

  post '/signup' do # did you do the sign up link?
    if logged_in?
      redirect "/tweets"
    else
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect "/tweets/index"
    end
  end

  get '/login' do
    erb :'/users/login'
  end

  post '/login' do
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect '/login'
    end
  end

  get '/users/:id' do
    @user = User.find_by(id: params[:id])
    @tweets = Tweet.all
    redirect :"/users/show"
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end

end
