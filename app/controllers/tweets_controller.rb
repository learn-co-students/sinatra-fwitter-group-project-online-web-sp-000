class TweetsController < ApplicationController

  get '/tweets' do
    if !logged_in?
      @tweets = Tweet.all
    else
      redirect '/login'
    erb :'/tweets/index'
  end

end
