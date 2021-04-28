class TweetsController < ApplicationController
    get '/tweets' do
        @tweets = Tweet.all
        erb :"tweets/tweets"
    end
    get '/tweets/:id/edit' do
        @tweet = Tweet.find(params[:id])
        erb :"tweets/edit_tweet"
    end
    get '/tweets/new' do
        erb :"tweets/new"
    end

    get '/tweets/:id' do
        @tweet = Tweet.find(params[:id])
        erb :"tweets/show_tweet"
    end
    post '/tweets' do
        #binding.pry
        if (params[:content] === "")
            redirect to "tweets/new"
        else
            @tweet = Tweet.create(content: params[:content], user_id: Helpers.current_user(session).id)
            redirect to "tweets/#{@tweet.id}"
        end
    end
    patch '/tweets/:id' do
        #binding.pry
        if (params[:content] === "")
            redirect to "tweets/#{params[:id]}/edit"
        else
            @tweet = Tweet.find(params[:id])
            @tweet.update(content: params[:content])
            redirect to "tweets/#{@tweet.id}"
        end
    end
end
