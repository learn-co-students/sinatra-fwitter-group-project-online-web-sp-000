class UsersController < ApplicationController

  get '/users/:slug' do
    @user = current_user
    erb :'users/show'
  end

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    end
    erb :'users/create_user'
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect '/signup'
    end
    user = User.create(params)
    session[:user_id] = user.id
    redirect '/tweets'
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    end
    erb :'users/login'
  end

  post '/login' do
    user = User.find_by(username: params[:username]).authenticate(params[:password])
    if user
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
    end
    redirect "/login"

  end

end
