class TweetsController < ApplicationController

    get '/tweets' do
      if !!User.find(session[:user_id])
        @user = User.find(session[:user_id])
        @tweets = Tweet.all
        erb :'/tweets/index'
      else
        erb :'/users/login'
      end
    end

end
