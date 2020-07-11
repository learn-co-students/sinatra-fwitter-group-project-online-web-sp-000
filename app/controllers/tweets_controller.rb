class TweetsController < ApplicationController

    get '/tweets' do
        erb :'/tweets/tweets'
    end

    get '/tweets/new' do
        @tweets = Tweet.all
        erb :'/tweets/new'
    end

    get '/tweets/:id' do
        @tweet = Tweet.find_by(id: params[:id])
        erb :'/tweets/show'
    end

    post '/tweets' do
        @tweet = Tweet.new(content: params[:content])
        redirect '/tweets/tweets'
    end
end
