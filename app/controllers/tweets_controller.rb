class TweetsController < ApplicationController

    get '/tweets' do
        if session[:user_id] 
            @tweets = Tweet.all
            @user = User.find(session[:user_id]) 
            erb :'tweets/index' 
        else
            redirect to '/login'
        end 
    end 

    get '/tweets/new' do 
        if !logged_in?(session)
            redirect to '/login'
        end 
        erb :'/tweets/new'
    end

    post'/tweets' do        
        if !params[:content].empty?
            @tweet = Tweet.create(content: params[:content])
            @tweet.user = User.find(session[:user_id])
            @tweet.save
        else
            redirect to '/tweets/new'
        end 
        redirect to '/tweets'
    end 

    get '/tweets/:id/edit' do
        if !logged_in?(session)
            redirect to '/login'
        end 

        @tweet = Tweet.find(params[:id])
        @user = User.find(session[:user_id])
        if @user == @tweet.user 
            erb :'/tweets/edit'
        else 
            redirect to '/tweets'
        end 
    end 

    patch '/tweets/:id/edit' do 
        @tweet = Tweet.find(params[:id])
        @tweet.update(content: params[:content])

    end 

    get '/tweets/:id/delete' do 
        tweet = Tweet.find(params[:id])
        user = User.find(session[:user_id])
        if tweet.user == user
            tweet.delete
        end
        redirect to '/login'
    end

    get '/tweets/:id' do 
        if !logged_in?(session)
            redirect to '/login'
        end

        @tweet = Tweet.find(params[:id])
        erb :'/tweets/show'
    end 

    helpers do
        def logged_in?(session)
            !!session[:user_id]
        end 

        def current_user(session)
            User.find(session[:user_id]) 
        end 
    end 
end
