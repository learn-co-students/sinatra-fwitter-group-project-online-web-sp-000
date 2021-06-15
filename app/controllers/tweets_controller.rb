class TweetsController < ApplicationController

    get '/tweets' do

        if Helpers.is_logged_in?(session)
            @user = Helpers.current_user(session)
            erb :'/tweets/index'
        else 
            redirect to '/login'
        end
    end

    get '/tweets/new' do
        erb :'/tweets/new'
    end


end
