require 'pry'
class TweetsController < ApplicationController

    get '/tweets' do 
        @tweets = Tweet.all 
      if logged_in?
        erb:'tweets/index' 
      else 
        redirect to "/login"
      end 
    end

    get '/tweets/new' do 
            erb:'/tweets/new'
    end 

    post '/tweets' do 
        if params[:content] != ""
            @tweet = Tweet.create(content: params[:content])
            current_user.tweets << @tweet
        else 
            redirect to "/tweets/new"
        end 
    end 

    

end
