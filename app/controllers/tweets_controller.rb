class TweetsController < ApplicationController
  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :'tweets/index'
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect "/login"
    end
  end
end
