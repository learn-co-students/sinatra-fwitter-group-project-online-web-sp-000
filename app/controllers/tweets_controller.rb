class TweetsController < ApplicationController

    get '/tweets' do
        if logged_in?
            @tweets = Tweet.all
            erb :'tweets/tweets'
        else
            redirect '/login'
        end
    end

    delete 'tweets/delete' do
        @tweet = Tweet.find_by_id(params[:id])
       # if logged_in? && @tweet.user_id = session[:user_id]
       #     @tweet.destroy
            #redirect '/tweets'
        #else
            #redirect '/login
       # end
    end

    post 'tweets/delete' do 
        
    end
end
