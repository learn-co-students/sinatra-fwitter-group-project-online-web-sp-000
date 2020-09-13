class TweetsController < ApplicationController
    #read all tweets 
    get '/tweets' do
        if logged_in?
            @tweets = Tweet.all
            @user = User.find(session[:user_id])
            erb :'tweets/tweets'
        else
            redirect '/login'
        end
    end
    
    #only show new tweet form for login user, or login page
    get '/tweets/new' do
        if logged_in? 
            erb :'tweets/new'
        else
            redirect '/login'
        end
    end
    
    #only create tweet for current user
    post '/tweets' do
        tweet = current_user.tweets.build(params)
        if tweet.save 
            redirect "/tweets/#{tweet.id}"
        else
            redirect '/tweets/new'
        end

    end
    
    #read specific tweet for log in user
    get '/tweets/:id' do
        if logged_in?
            @tweet = Tweet.find(params[:id])
            erb :'tweets/show_tweet'
        else
            redirect '/login'
        end
    end
    
    #show edit form for specific tweet, only if the tweet is created by current user and user is logged in.
    get '/tweets/:id/edit' do
        @tweet = Tweet.find_by(params[:id])
        if logged_in? && current_user == @tweet.user
            erb :'tweets/edit_tweet'
        else
            redirect '/login'
        end
    end

    patch '/tweets/:id' do
        tweet = Tweet.find_by(params[:id])
        if tweet.user == current_user && params[:content]!=""
            tweet.update(content: params[:content])
            redirect "/tweets/#{tweet.id}"
        else
            redirect "/tweets/#{tweet.id}/edit"
        end

    end

    delete '/tweets/:id' do
        tweet = Tweet.find_by(id: params[:id])
        slug = tweet.user.slug
        if logged_in? && current_user == tweet.user
            tweet.destroy
            redirect "/users/#{slug}" 
        else
            redirect '/login'
        end
    end


end
