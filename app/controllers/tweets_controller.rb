class TweetsController < ApplicationController

    get '/tweets' do
        if Helpers.is_logged_in?(session)
            @tweets = Tweet.all
            erb :'tweets/tweets'
        else
            redirect to '/login'
        end
    end

    get '/tweets/new' do
        if Helpers.is_logged_in?(session)
            erb :'tweets/new'
        else
            redirect to '/login'
        end
    end

    post '/tweets' do
        if params[:content] != ''
            user = Helpers.current_user(session)
            user.tweets.build(content: params[:content])
            user.save
        else
            redirect to '/tweets/new'
        end
    end
end
