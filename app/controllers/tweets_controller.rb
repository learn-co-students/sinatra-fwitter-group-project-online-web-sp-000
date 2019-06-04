class TweetsController < ApplicationController

  get '/tweets' do
    if !logged_in?(session)
      redirect "/login"
    end
    @user = current_user(session)
    @tweets = Tweet.all
    # binding.pry
    erb :'/tweets/index'
  end

  get '/tweets/new' do
    
  erb :'/tweets/new'
  end
end
