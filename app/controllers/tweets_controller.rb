class TweetsController < ApplicationController

    get '/tweets' do
        if session[:id]
            @tweets = Tweet.all
            erb :'tweets/index'
        else
            redirect '/signup'
        end
    end

end
