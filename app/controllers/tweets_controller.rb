class TweetsController < ApplicationController

    get '/tweets' do

        if logged_in?
            erb :'/tweets/index'
        else 
            redirect to '/login'
        end
        
    end

end
