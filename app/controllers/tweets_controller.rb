class TweetsController < ApplicationController

    get '/tweets' do 
        if logged_in? 
            @user = User.find_by_id(session[:user_id])
            @tweets = Tweet.all 
            erb :'/tweets/tweets'
        else 
            redirect '/login' 
        end 
    end 

    get '/tweets/new' do
        if logged_in? 
            erb :'/tweets/new'
        else 
            redirect '/login'
        end 
    end 

    post '/tweets' do 
        if params[:content] != ""
            @tweet = Tweet.create(content: params[:content])
            @tweet.update(:user_id => session[:user_id]) 
        else 
            redirect '/tweets/new'
        end 
    end 

    get '/tweets/:id' do 
        if logged_in? 
            @tweet = Tweet.find_by_id(params[:id])
            erb :'/tweets/show_tweet'
        else 
            redirect '/login'
        end 
    end 

    get '/tweets/:id/edit' do 
        @tweet = Tweet.find_by_id(params[:id])

        if logged_in? 
            if session[:user_id] == @tweet.user_id
                erb :'/tweets/edit_tweet'
            else
                redirect '/tweets'
            end 
        else 
            redirect '/login'
        end 
    end 

    patch '/tweets/:id' do 
        @tweet = Tweet.find_by_id(params[:id])
        if logged_in? && @tweet.user_id == session[:user_id]
            if params[:content].empty? 
                redirect "/tweets/#{@tweet.id}/edit"
            else 
                @tweet.update(:content => params[:content])
                redirect "/tweets/#{@tweet.id}"
            end 
        else 
            redirect '/tweets'
        end 
    end 

    delete '/tweets/:id' do 
        @tweet = Tweet.find_by_id(params[:id])

        if logged_in? && session[:user_id] == @tweet.user_id
            @tweet.delete
            redirect '/tweets'
        else
            redirect '/tweets'
        end 
    end 


end
