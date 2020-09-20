class TweetsController < ApplicationController

    get '/tweets' do
        @tweets = Tweet.all
        @users = User.all
        erb :'/tweets/all'
    end

    get '/tweets/:id' do 
        @tweet = Tweet.find[:id]
        erb :'/tweets/show_tweet'
    end


end
