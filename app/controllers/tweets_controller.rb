class TweetsController < ApplicationController

    get '/tweets' do
        if Helpers.is_logged_in?(session)
            @session = session
            @user = User.find(session[:user_id])
            erb :'tweets/index'
        else
            redirect to '/login'
        end
    end

    get '/tweets/new' do
        if Helpers.is_logged_in?(session)
            @session = session
            @user = User.find(session[:user_id])
            erb :'tweets/new'
        else
            redirect to '/login'
        end
    end

    post '/tweets' do
        if params[:content] == ""
            redirect to '/tweets/new'
        else
            @tweet = Tweet.create(content: params[:content], user_id: session[:user_id])
        end
    end

    get '/tweets/:id/edit' do
        if Helpers.is_logged_in?(session)
            @tweet = Tweet.find(params[:id])
            @session = session
            erb :'tweets/edit'
        else
            redirect to '/login'
        end
    end

    get '/tweets/:tweet_id' do
        if Helpers.is_logged_in?(session)
            @tweet = Tweet.find(params[:tweet_id])
            erb :'tweets/show'
        else
            redirect to '/login'
        end
    end

    patch '/tweets/:id/edit' do
        @tweet = Tweet.find(params[:id])
        if !(params[:content] == "")
            @tweet.content = params[:content]
        end
        @tweet.save
    end

    delete '/tweets/:id' do
        @tweet = Tweet.find(params[:id])
        if (@tweet.id == session[:user_id])
            @tweet.delete
        end
        redirect to '/tweets'
    end

end
