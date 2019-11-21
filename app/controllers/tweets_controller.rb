class TweetsController < ApplicationController

    get '/tweets' do
        @tweets=Tweet.all
        if Helpers.is_logged_in?(session)
            @user=User.find_by_id(session[:user_id])
        erb :'tweets/index'
        else
            redirect to "/login"
        end
    end


end
