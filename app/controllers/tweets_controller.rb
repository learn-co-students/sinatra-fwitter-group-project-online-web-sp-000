class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @all_tweets = Tweet.all
      @user = current_user
      erb :'/tweets/show'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/new'
    else

    end
  end
end
