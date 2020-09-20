class TweetsController < ApplicationController

    get '/tweets' do
        if logged_in?
            @tweets = Tweet.all
            erb :'/tweets/all'
        else
            redirect to '/login'
        end
    end
    
    get '/tweets/new' do
        if logged_in?
            erb :"/tweets/new"
        else
            redirect to '/login'
        end
    end

    

end
