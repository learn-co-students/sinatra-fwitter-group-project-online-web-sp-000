class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
    erb :'/tweets/tweets'
    else
    redirect '/login'
    end
  end

  get '/tweets/new' do

  end

  post '/tweets' do

  end




end
