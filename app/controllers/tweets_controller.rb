# require 'rack-flash'
class TweetsController < ApplicationController

    get '/tweets' do
        @tweets = Tweet.all
        if User.is_logged_in?(session)
            @user = User.find(session[:user_id])
            erb :"/tweets/tweets"
        else
            redirect "/login"
        end
    end

    post '/tweets' do 
        @user =  User.find(session[:user_id])
        tweet = Tweet.create(content: params[:content])
        if tweet.content != ""
        @user.tweets << tweet
        end
        redirect "/tweets/#{tweet.id}"
    end

    get '/tweets/new' do 
        if User.is_logged_in?(session)
            erb :"/tweets/new"
        end
    end

    get '/tweets/:id' do 
        @tweet = Tweet.find(params[:id])
        @user =  User.find(@tweet.user_id)
        erb :"/tweets/show_tweet"
    end


    get '/tweets/:id/edit' do
        @tweet = Tweet.find(params[:id])
        erb :"/tweets/edit_tweet"
    end

    delete '/tweets/:id/delete' do 
        tweet = Tweet.find(params[:id])
        if User.current_user(session).id == tweet.user_id
            @user =  User.find(tweet.user_id)
            id = tweet.user_id
            tweet.destroy
         end
         erb :"/users/show"
    end

    patch '/tweets' do 
        if params[:content] != ""
        tweet = Tweet.find(params[:id])
        tweet.update(:content => params[:content])
        redirect "/tweets/#{tweet.id}"
        else 
            redirect "/tweets/#{params[:id]}/edit"
        end
    end

end
