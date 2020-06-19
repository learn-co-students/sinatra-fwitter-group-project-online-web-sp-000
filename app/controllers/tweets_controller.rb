require 'pry'
class TweetsController < ApplicationController

    get '/tweets' do 
        if !logged_in?
            redirect to '/login'
        else
            @tweets = Tweet.all
            @user = self.current_user
            erb :'/tweets/tweets'
        end 
    end 

    get '/tweets/new' do 
        if !logged_in?
            redirect to '/login'
        else 
            erb :'/tweets/new'
        end 
    end 

    post '/tweets' do 
        if !params[:content].empty?
            @tweet = Tweet.create(content: params[:content], user_id: session[:user_id])
            @tweet.save
        else 
            redirect to '/tweets/new'
        end 
    end 

    get '/tweets/:id' do 
        if !logged_in?
            redirect to '/login'
        else 
            @tweet = Tweet.find_by(user_id: params[:id])
            erb :'/tweets/show_tweet'
        end 
    end 

    get '/tweets/:id/edit' do 
        if !logged_in? 
            redirect to '/login'
        else 
            @tweets = Tweet.find_by(user_id: session[:user_id])
            erb :'/tweets/edit_tweet'
        end 
    end 
    
    patch '/tweets/:id' do 
        if params[:content].empty?
            redirect to "/tweets/#{params[:id]}/edit"
        end 
        @tweets = Tweet.find_by(user_id: params[:id])
        @tweets.update(content: params[:content])
        @tweets.save
        redirect to "/tweets/#{@tweets.id}"
    end 

    post '/tweets/:id/delete' do 
        @tweet = Tweet.find_by(user_id: params[:id])
        if current_user.id != @tweet.user_id
            redirect to '/tweets'
        end 
        @tweet.delete
        redirect to '/tweets'
    end 


end
