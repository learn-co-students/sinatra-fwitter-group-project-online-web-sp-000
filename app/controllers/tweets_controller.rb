class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
  end

  get '/tweets/:id' do
  end

  get '/tweets/:id/edit' do
  end

end
