class TweetsController < ApplicationController
    
    get '/tweets/new' do
        if logged_in?
            erb :'/tweets/new'
        else
            redirect '/login'
        end
    end

    post '/tweets' do
        if params[:content] == ""
            redirect '/tweets/new'
        else
            User.find(session[:user_id]).tweets.build(content: params[:content]).save
        end
    end

    get '/tweets/:id' do
        if logged_in?
            @tweet = Tweet.find(params[:id])
            erb :'/tweets/show_tweet'
        else
            redirect '/login'
        end
    end

    get '/tweets/:id/edit' do
        if logged_in?
            @tweet = Tweet.find(params[:id])
            if session[:user_id] == @tweet.user_id
                erb :'/tweets/edit_tweet'
            end
        else
            redirect '/login'  
        end
    end

    patch '/tweets/:id/edit' do
        if params[:content] != ""
            @tweet = Tweet.find(params[:id])
            @tweet.content = params[:content]
            @tweet.save
        end
        redirect "/tweets/#{@tweet.id}"
    end

    delete '/tweets/:id/delete' do
        if logged_in?
            @tweet = Tweet.find(params[:id])
            if session[:user_id] == @tweet.user_id
                @tweet.destroy
            end
        else
            redirect '/login'  
        end
    end


end
