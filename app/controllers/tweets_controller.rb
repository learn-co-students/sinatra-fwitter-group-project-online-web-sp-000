class TweetsController < ApplicationController

    get '/tweets' do
        if logged_in?
            @user = User.find(session[:user_id])
            @tweets = Tweet.all
            erb :"/tweets/index"
        else
            redirect "/login"
        end
    end

    get '/tweets/new' do 
        if logged_in?
            @user = current_user
            erb :'/tweets/new'
        else
            redirect '/login'
        end
    end

    post '/tweets' do
        @user = current_user
        if !params[:tweet][:content].empty?
            @user.tweets.create(params[:tweet]) 
        else
            redirect '/tweets/new'
        end
    end
    
    get '/tweets/:id' do
        @tweet = find_tweet
        if logged_in?
            erb :'/tweets/show'
        else
            redirect '/login'
        end
    end

    get '/tweets/:id/edit' do
        @tweet = find_tweet
        if logged_in? 
            if current_user.tweets.include?(find_tweet)
                erb :'/tweets/edit'
            else
                redirect "/tweets"
            end
        else
            redirect "/login"
        end
    end

    patch '/tweets/:id' do 
        tweet = find_tweet
        if !params[:tweet][:content].empty?
            tweet.update(params[:tweet])
            redirect "/tweets/#{tweet.id}"
        else
            redirect "/tweets/#{tweet.id}/edit"
        end
    end
    

    delete '/tweets/:id' do
        tweet = find_tweet 
        if logged_in? && current_user.tweets.include?(find_tweet)
        else
            redirect "/tweets/#{tweet.id}"
        end
    end



end
