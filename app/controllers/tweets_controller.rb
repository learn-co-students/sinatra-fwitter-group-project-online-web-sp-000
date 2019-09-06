class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect '/signup'
    end
  end

  get '/tweets/new' do
  end

  get '/tweets/:id' do
  end

  get '/tweets/:id/edit' do
  end
  
end
