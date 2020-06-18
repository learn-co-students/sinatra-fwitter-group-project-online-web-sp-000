require 'pry'
class TweetsController < ApplicationController

    get '/tweets' do 
        if !logged_in?
            redirect to '/login'
        else
            erb :'/tweets/tweets'
        end 
    end 
    


end
