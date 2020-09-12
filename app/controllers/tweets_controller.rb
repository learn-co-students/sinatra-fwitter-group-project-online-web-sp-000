class TweetsController < ApplicationController

    get '/tweets' do
        #binding.pry
        @tweets = Tweet.all
        erb :"tweets/tweets"
        #if user is logged in-> direct to tweets/tweets
        #if not logged in -> direct to login page users/login
    end
end
