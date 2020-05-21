class TweetsController < ApplicationController
    
    get '/tweets' do
        @user = User.find {|u| u.id == session[:user_id]}
        @tweets = User.all.collect {|u| u.tweets}.flatten
        if logged_in?
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
        if params[:content] != ""
            @tweet = Tweet.create(content: params[:content])
            @user = User.find(session[:user_id])
            @user.tweets << @tweet
            redirect "/tweets/#{@tweet.id}"
        else
            redirect '/tweets/new'
        end
    end

    get '/tweets/:id' do
        if logged_in?
            @user = User.find(session[:user_id])
            @tweet = Tweet.find(params[:id])
            erb :'tweets/show_tweet'
        else
            redirect '/login'
        end
    end

    get '/tweets/:id/edit' do
        if logged_in?
            @tweet = Tweet.find(params[:id])
            erb :'tweets/edit_tweet'
        else
            redirect '/login'
        end
    end

    patch '/tweets/:id' do
        @user = User.find {|u| u.id == session[:user_id]}
        @tweet = Tweet.find(params[:id])
        if @user.tweets.include?(@tweet)
            if params[:content] != ""
                @tweet.update(content: params[:content])
            else
                redirect "tweets/#{@tweet.id}/edit"
            end
        else
            redirect '/tweets'
        end
    end

    delete '/tweets/:id/delete' do
        if logged_in?
            @tweet = Tweet.find(params[:id])
            if @tweet.user == User.find {|u| u.id == session[:user_id]}
                @tweet.delete
            else
                redirect "/tweets/#{@tweet.id}"
            end
        else
            redirect '/login'
        end
    end
end
