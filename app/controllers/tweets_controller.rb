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

    get '/tweets/:id' do
        @tweet = Tweet.find(params[:id])
        if Helpers.is_logged_in?(session)
            erb :'tweets/show_tweet'
        else
            redirect to '/login'
        end
    end

    delete '/tweets/:id' do
        tweet = Tweet.find(params[:id])
        if Helpers.is_logged_in?(session) && Helpers.current_user(session).id == tweet.user.id
            tweet.destroy
        end
        redirect to '/tweets'
    end

    get '/tweets/:id/edit' do
        if Helpers.is_logged_in?(session)
            user = Helpers.current_user(session)
            @tweet = Tweet.find(params[:id])
            if user && @tweet.user.id == user.id
                erb :'tweets/edit_tweet'
            else
                redirect to 'login'
            end
        else
            redirect to 'login'
        end
    end

    post '/tweets/:id' do
        tweet = Tweet.find(params[:id])
        if params[:content] != ''
            tweet.update(content: params[:content])
            redirect to "/tweets/#{tweet.id}"
        else
            redirect to "/tweets/#{tweet.id}/edit"
        end
    end
end