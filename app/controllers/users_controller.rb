class UsersController < ApplicationController
  before '/user*' do
    authentication_required
  end

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    end
    erb :'users/create_user'

  end

  post '/signup' do
    new_user = User.new(params)
    if new_user.username.empty? or new_user.email.empty? or !new_user.save
      redirect '/signup'
    end
    session[:user_id] = new_user.id
    redirect '/tweets'
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    end
    erb :'users/login'
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/login'
    end

  end

  get '/logout' do
    if !logged_in?
      redirect '/'
    end
    session.clear
    redirect '/login'
  end

  get '/users/:slug' do
    @user = current_user
    binding.pry
    erb :'users/show'
  end
end
