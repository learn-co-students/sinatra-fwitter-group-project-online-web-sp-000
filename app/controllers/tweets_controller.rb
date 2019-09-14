class TweetsController < ApplicationController

    get '/tweets' do
        if logged_in?
            @user = User.find(session[:user_id])
            @tweets = Tweet.all
            erb:'tweets/tweets'
        else
            redirect to '/login'
        end
    end

    get '/tweets/new' do
        if logged_in?
            erb:'tweets/new'
        else
            redirect to '/login'
        end
    end

     post '/tweets' do
        if params[:content] != ""
            tweet = Tweet.create(content: params[:content], user_id:session[:user_id])
            redirect to "/tweets/#{tweet.id}"
        else
            redirect to '/tweets/new'
        end 
     end

     get '/tweets/:id' do
        if logged_in?
            @tweet = Tweet.find(params[:id])
            erb:'/tweets/show_tweet'
        else
            redirect to '/login'
        end
     end

     get '/tweets/:id/edit' do
        if logged_in?
            user = User.find(session[:user_id])
            @tweet = Tweet.find(params[:id])
            if user.tweets.include?(@tweet)
                erb:'/tweets/edit_tweet'
            else
                redirect to "/tweets/#{@tweet.id}"
            end
        else
            redirect to '/login'
        end
     end

     patch '/tweets/:id' do
        if logged_in?
            tweet = Tweet.find(params[:id])
            if params[:content] != ""
                tweet.update(content: params[:content])
            end
            redirect to "/tweets/#{tweet.id}/edit"
        else
            redirect to '/login'
        end
     end

     delete '/tweets/:id' do
        if logged_in?
            user = User.find(session[:user_id])
            tweet = Tweet.find(params[:id])
            if user.tweets.include?(tweet)
                Tweet.destroy(params[:id])
            end
            redirect to '/tweets'
        else
            redirect to '/login'
        end 
     end







end
