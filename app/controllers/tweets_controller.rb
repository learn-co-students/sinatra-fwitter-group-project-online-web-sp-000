class TweetsController < ApplicationController
  get '/tweets' do
    @user = current_user
    @tweets = Tweet.all
    erb :"/tweets/tweets"
  end
end