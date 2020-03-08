class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'users/signup'
    end
  end

  post '/signup' do
    if fields_filled?
      login(User.create(username: params[:username], email: params[:email], password: params[:password])) #creates and logs in user
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    if fields_filled?
      user = User.find_by(username: params[:username])
      if user && user.authenticate(params[:password])
        login(user)
        redirect '/tweets'
      else
        redirect '/login'
      end
    else
      redirect '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end

  get '/users/:id' do
    @user = User.find(params[:id])
    @all = Tweet.tweets_by_user(@user)
    erb :'users/show'
  end


end
