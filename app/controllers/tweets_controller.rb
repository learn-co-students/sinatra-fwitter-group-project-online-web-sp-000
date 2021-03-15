class TweetsController < ApplicationController

    get '/tweets' do
        @tweets = Tweet.all
        erb :'/tweets/index'
    end

    get '/tweets/new' do
        erb :'/tweets/new'
    end

    post '/tweets' do
        @tweet = Tweet.find_by_id(params[:id])
        redirect to "/tweets/#{@tweet.id}"
    end

    get '/tweets/:id' do
        @tweet = Tweet.find_by_id(params[:id])
        erb :'/tweets/show'
    end

    get '/tweets/:id/edit' do

    end

    patch '/tweets/:id/edit' do

    end

    get '/tweets/:id/delete' do

    end
end
