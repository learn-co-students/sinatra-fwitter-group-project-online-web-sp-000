class UsersController < ApplicationController

  get '/login' do
    if !logged_in?
      erb :'/users/login'
    else
      redirect :'/tweets'
    end
  end

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    end
    erb :'/users/signup'
  end
  
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    tweets = Tweet.all
    @user_tweets = tweets.collect do |tweet|
      tweet[user] == @user
    end
    erb :'/users/show'
  end

  post '/signup' do
    user = User.new(params[:user])
    if (user.username != "") && (user.email != "") && (user.password != "") && (user.save)
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:user][:username])
    if (user.username != "") && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect "/login"
  end

end
