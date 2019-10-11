class TweetsController < ApplicationController
  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :"/tweets/tweets"
    else
      redirect "/login"
    end
  end
  
  get '/tweets/new' do
    if logged_in?
      erb :"/tweets/new"
    else
      redirect "/users/login"
    end
  end
end