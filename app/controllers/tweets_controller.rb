class TweetsController < ApplicationController

    get '/tweets' do
        if session[:user_id] 
            @tweets = Tweet.all
            @user = User.find(session[:user_id]) 
            erb :'tweets/index' 
        else
            redirect to '/login'
        end 
    end 

end
