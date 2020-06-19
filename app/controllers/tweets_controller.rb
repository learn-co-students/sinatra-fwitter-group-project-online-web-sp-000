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
    


end
