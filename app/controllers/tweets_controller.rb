class TweetsController < ApplicationController

  get '/tweets' do
    @tweets = Tweet.all
    erb :tweets
  end

  get '/tweets/new' do
    if Helpers.is_logged_in?(session)
      erb :new_tweet
    end
  end

end
