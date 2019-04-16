class TweetsController < ApplicationController
  get '/tweets' do
    @tweets = Tweet.all

    erb :'tweets/tweets'
  end

end
