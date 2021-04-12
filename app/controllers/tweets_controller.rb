class TweetsController < ApplicationController

    get '/tweets' do
        if logged_in?
            @user = current_user
            @tweets = Tweet.all
            erb :'tweets/index'
        else
            redirect to "/login"
        end
    end

    get '/tweets/new' do
        if logged_in?
            erb :'tweets/new'
        else
            redirect to "/login" 
        end
    end

    post '/tweets' do
        if logged_in? && current_user && params[:content] != ""
            @tweet = Tweet.create(content: params[:content])
            @tweet.user_id = current_user.id
            @tweet.save
        else
            redirect to '/tweets/new'
        end
    end

    get '/tweets/:id' do
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            erb :'/tweets/show'
        else
            redirect to '/login'
        end
    end

    get '/tweets/:id/edit' do
        if logged_in? && current_user
            @tweet = Tweet.find_by_id(params[:id])
            erb :'tweets/edit'
        else
            redirect to "/login"
        end
    end

    patch '/tweets/:id' do
        @tweet = Tweet.find_by_id(params[:id])
        if logged_in? && params[:tweet][:content] != ""
            @tweet.update(content: params[:tweet][:content])
            @tweet.save

            redirect to "/tweets/#{@tweet.id}"
        else
            redirect to "/tweets/#{@tweet.id}/edit"
        end
    end

    delete '/tweets/:id/delete' do
        @tweet = Tweet.find_by_id(params[:id])
        if logged_in? && current_user[:id] == @tweet.user_id
            @tweet.delete

            redirect to "/tweets"
        else
            redirect to "/login"
        end
    end
end
