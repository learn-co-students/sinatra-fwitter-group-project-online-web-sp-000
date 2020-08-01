class TweetsController < ApplicationController

    get '/tweets' do 
        @tweets = Tweet.all 
        erb :'/tweets/index'
    end 
    
    get '/login' do 
      erb :'/tweets/index'
    end 

end
