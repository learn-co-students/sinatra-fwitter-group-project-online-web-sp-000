class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in
      @tweets = Tweet.all
      erb :'/tweets/index'
    else
      redirect '/login'
    end
  end


  get '/tweets/new' do

    erb :'/tweets/new'
  end

  post '/tweets' do
    @tweet = Tweet.create(params[:content])
    @tweet.user = User.create(user[:username], user[:email], user[:password])

  end

  # get '/signup' do
  #   @user = User.create(user[:username], user[:email], user[:password])
  #   @session = session[:name] = @user.name
  #     if session[:name] == ( user[:username] && user[:password] )
  #       redirect '/login'
  #     else "Incorrect username or password!"
  #     end
  #   erb :'/tweets/index'
  # end


end
