class TweetsController < ApplicationController

    get '/tweets' do
        #binding.pry
        if !!Helpers.is_logged_in?(session)
            redirect '/login'
        else
            @user = User.find_by(session[:HTTP_USER_AGENT])
            @tweets = Tweet.all
            erb :"tweets/tweets"
        end
    end
end
