class TweetsController < ApplicationController

    get '/tweets' do
        if !!logged_in?
            @user = current_user
            erb :"/tweets/tweets"
        else
            redirect '/login'
        end
    end

    get '/tweets/new' do
        if !!logged_in?
            erb :"/tweets/new"
        else
            redirect '/login'
        end
    end

    post '/tweets' do
        if params[:content] == ("")
            redirect '/tweets/new'
        else
            #binding.pry
            user = current_user
            tweet = Tweet.create(content: params[:content], user_id: user.id)
            #tweet.user_id = user.id
        end
    end

    get '/tweets/:id' do
        if !!logged_in?
            id = params[:id]
            @tweet = Tweet.find(id)
            erb :"/tweets/show_tweets"
        else
            redirect '/login'
        end
    end

    get '/tweets/:id/edit' do
        redirect "/login" unless !!logged_in?
        @tweet = Tweet.find(params[:id])
        #owner = User.find(@tweet.user_id)
        @user = current_user
        if @user.id == @tweet.user_id
            erb :"/tweets/edit_tweet"
        else
            redirect "/tweets/#{@tweet.id}"
        end
    end

    patch '/tweets/:id' do
        if params[:content] == ""
            redirect "/tweets/#{params[:id]}/edit"
        else
            @tweet = Tweet.find(params[:id])
            @tweet.update(content: params[:content])
            redirect "/tweets/#{@tweet.id}"
        end
    end

    delete '/tweets/:id' do
        redirect "/login" unless !!logged_in?
        @tweet = Tweet.find(params[:id])
        @tweet.destroy if current_user.id == @tweet.user_id
        redirect "/tweets"
    end

end
