require 'pry'
class TweetsController < ApplicationController

    get '/tweets' do 
        if !logged_in?
            redirect to '/login'
        else
            @tweets = Tweet.all
            @user = self.current_user
            erb :'/tweets/tweets'
        end 
    end 

    get '/tweets/new' do 
        if !logged_in?
            redirect to '/login'
        else 
            erb :'/tweets/new'
        end 
    end 
    


end
