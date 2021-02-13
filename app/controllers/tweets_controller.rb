class TweetsController < ApplicationController

    get '/tweets' do 
        if !logged_in? 
            redirect '/login'
        else 
            erb :'tweets/index'
        end 
    end 

    get '/tweets/new' do 
        if !logged_in? 
            redirect '/login'
        else 
            erb :'tweets/new'
        end 
    end 

    get '/tweets/:id' do 
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            erb :'tweets/show'
        else 
            redirect '/login'
        end
    end 

    get '/tweets/:id/edit' do 
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            erb :'tweets/edit'
        else 
            redirect '/login'
        end 
    end 

    #get '/tweets/:id/delete' do 
        #if logged_in?
           # @tweet = Tweet.find_by_id(params[:id])
           # erb :'/tweets/delete'
        #else 
            #redirect '/login'
       # end 
    #end 

    post '/tweets' do 
        #binding.pry
        @user = current_user
        if @user && params[:content] != ""
            @tweet = Tweet.create(params)
            @user.tweets << @tweet
            redirect "/tweets/#{@tweet.id}"
        else 
            redirect '/tweets/new'
        end 
    end 

    patch '/tweets/:id' do 
        #binding.pry
        @user = current_user
        @tweet = Tweet.find_by_id(params[:id])
        if @user && params[:content] != ""
            @tweet.update(content: params[:content])
            redirect "/tweets/#{@tweet.id}"
        else 
            redirect "/tweets/#{@tweet.id}/edit"
        end
    end 

    delete '/tweets/:id' do 
        #binding.pry
        @user = current_user 
        @tweet = Tweet.find_by_id(params[:id])
        if @user && @user.tweets.include?(@tweet)
            @tweet.destroy
            redirect '/tweets'
        else 
            redirect '/login'
        end 
    end 

    
    
end
