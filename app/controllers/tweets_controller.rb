class TweetsController < ApplicationController

  get '/tweets' do
    @all_tweets = Tweet.all
    @all_users = User.all

    erb :'tweets/index'
  end

end
