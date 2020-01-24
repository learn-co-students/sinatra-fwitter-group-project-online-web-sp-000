class TweetsController < ApplicationController

    get '/tweets' do
        if logged_in?
            erb :'tweets/tweets'
        else
            redirect '/login'
        end
        
    end


end
