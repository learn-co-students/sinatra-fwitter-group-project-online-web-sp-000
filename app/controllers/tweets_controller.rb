class TweetsController < ApplicationController

    get '/tweets' do 
        if !logged_in? 
            redirect '/login'
        else 
            erb :'tweets/index'
        end 
    end 
    
end
