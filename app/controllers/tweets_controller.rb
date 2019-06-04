class TweetsController < ApplicationController

  get '/tweets' do
    if !logged_in?(session)
      redirect "/login"
    end
    @user = current_user(session)
    @tweets = Tweet.all

    erb :'/tweets/index'
  end
end
