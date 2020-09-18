class TweetsController < ApplicationController

    get '/tweets' do
        @tweets = Tweet.all
        @users = User.all
        erb :'/tweets/all'
    end


end
