class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in
      @tweets = Tweet.all
    erb :'/tweets/tweets'
  end

  get '/tweets' do

    erb :'/tweets/new'
  end

  post '/tweets' do

    redirect '/tweets/:id'
  end



end
