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
        else
            redirect "/"
        end
    end

    get '/tweets/:id' do 
        if User.is_logged_in?(session)
        @tweet = Tweet.find(params[:id])
        @user =  User.find(@tweet.user_id)
        erb :"/tweets/show_tweet"
        else
            redirect "/"
        end
    end


    get '/tweets/:id/edit' do
   
        if User.is_logged_in?(session)
            @tweet = Tweet.find(params[:id])
            if @tweet.user_id == session[:user_id]
                erb :"/tweets/edit_tweet"
            else
                redirect "/"
            end
        else
            redirect "/"
        end
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
