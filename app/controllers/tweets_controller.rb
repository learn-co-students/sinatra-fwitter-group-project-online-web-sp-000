class TweetsController < ApplicationController

    get '/tweets' do 
        @tweets = Tweet.all 
        if is_logged_in?
          erb :'/index'
        else 
          redirect to '/login'
        end 
    end 



   
    
end
