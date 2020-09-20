class TweetsController < ApplicationController

    get '/tweets' do
        if logged_in?
            @tweets = Tweet.all
            @users = User.all
            erb :'/tweets/all'
        else
            redirect to '/login'
        end
    end

    get '/tweets/:id' do 
        @tweet = Tweet.find[:id]
        erb :'/tweets/show_tweet'
    end


end
