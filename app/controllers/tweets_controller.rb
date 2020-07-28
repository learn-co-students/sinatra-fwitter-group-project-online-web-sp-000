class TweetsController < ApplicationController

    get '/tweets' do
        if Helpers.logged_in?(session)
            @tweets = Tweet.all
            erb :'tweets/tweets'
        else
            erb :'users/login'
        end
    end

    get '/tweets/new' do
        erb :'tweets/new'
    end

    post '/tweets' do
        @tweet = Tweet.create(content: params[:content])
        redirect to '/tweets/:id'
    end

    get '/tweets/:id' do
        @tweet = Tweet.find(params[:id])
        erb :'tweets/show_tweet'
    end

    get '/tweets/:id/edit' do
        @tweet = Tweet.find(params[:id])
        erb :'tweets/edit_tweet'
    end

    patch '/tweets/:id' do
        tweet = Tweet.find(params[:id]).update(content: params[:content])
        redirect to "/tweets/#{tweet.id}"
    end

    delete '/tweets/:id' do
        Tweet.find(params[:id]).destroy
        # redirect to '/users/'
    end

end
