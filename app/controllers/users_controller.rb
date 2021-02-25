class UsersController < ApplicationController

  get '/users' do
    @users = User.all

    erb :'users/index'
  end

  get '/login' do
    redirect '/tweets' if logged_in?

    erb :'users/login'
  end

  post '/login' do
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/login'
    end

  end

  get '/logout' do
    logout

    redirect '/login'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(slug)

    erb :'users/show'
  end

end
