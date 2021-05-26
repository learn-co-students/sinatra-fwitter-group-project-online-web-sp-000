class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else redirect to '/users/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :"/tweets/new"
    else
      redirect to '/users/login'
    end
  end

  post '/tweets/' do
    if logged_in?
      @tweet = Tweet.create(content: params[:content])

    end
  end

end
