class TweetsController < ApplicationController

    get '/tweets' do 
        @tweets = Tweet.all 
      if logged_in?
        erb:'tweets/index' 
      else 
        redirect to "/login"
      end 
    end

end
