class TweetsController < ApplicationController

    get '/tweets' do
        if logged_in?
            @error = session[:message]
            @tweets = Tweet.all
            @user = current_user
            erb :'tweets/index'
        else
            redirect '/login'
        end
    end

    get '/tweets/new' do
        if logged_in?
           erb :'tweets/new' 
        else
            redirect '/login'
        end
    end

    post '/tweets' do
        user = current_user
        if params[:content].empty?
            session[:message] = "Content cannot be left empty."
            redirect '/tweets/new'
        else
            new_tweet = Tweet.create(content: params[:content])
            user.tweets << new_tweet
            redirect "users/#{user.slug}"
        end
    end

    get '/tweets/:id' do
        if logged_in?
            @tweet = Tweet.find(params[:id])  
            erb :'tweets/show'
        else
            redirect '/login'
        end
    end

    get '/tweets/:id/edit' do
        @message = current_message
        @tweet = Tweet.find(params[:id])
        if !logged_in? 
            redirect '/login'
        else
            erb :'/tweets/edit'
        end
    end

    patch '/tweets/:id/edit' do
        if logged_in?
            tweet = Tweet.find(params[:id])
            if current_user.tweets.include?(tweet)
                check_params(params, "tweets/#{tweet.id}/edit")
                tweet.update(content: params[:content])
                redirect "tweets/#{tweet.id}"
            else
                redirect '/login'
            end
        else
            redirect "/login"
        end
    end

    delete '/tweets/:id/delete' do
        tweet = Tweet.find(params[:id])
        if logged_in?
            if current_user.tweets.include?(tweet)
                tweet.destroy
            else
                redirect '/login'
            end
        else
            redirect '/login'
        end
    end

end
