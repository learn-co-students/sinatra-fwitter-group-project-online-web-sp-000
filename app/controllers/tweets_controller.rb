class TweetsController < ApplicationController

    get '/tweets' do
        if Helper.logged_in?(session)
            erb :'tweets/tweets'
        else
            redirect to '/login'
        end
    end

end
