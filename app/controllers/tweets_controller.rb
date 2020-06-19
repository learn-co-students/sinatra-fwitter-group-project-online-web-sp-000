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
        end 
        @tweets = Tweet.find_by(user_id: session[:user_id])
        # if current_user.id != @tweets.user_id
        #     redirect to '/tweets'
        # end

        erb :'/tweets/edit_tweet'
    end 
    
    patch '/tweets/:id' do 
    end 


end
