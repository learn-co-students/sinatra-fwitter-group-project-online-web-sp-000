class TweetsController < ApplicationController

    get '/tweets' do
        if logged_in? 
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
        #can this be refeactored?
        if !params[:content].empty?
            tweet = Tweet.new(params)
            tweet.user_id = current_user.id
            tweet.save
            redirect "/tweets/#{tweet.id}"
        else
            redirect '/tweets/new'
        end
    end

    get '/tweets/:id/delete' do
        @tweet = Tweet.find(params[:id])
        if logged_in? && @tweet.user_id == current_user.id
            @tweet.destroy
            redirect "/tweets"
        else
            redirect '/login'
        end
    end

    get '/tweets/:id/edit' do
        if logged_in? 
            @tweet = Tweet.find(params[:id])
            erb :'/tweets/edit_tweet'
        else
            redirect '/login'
        end
    end

    patch '/tweets/:id' do
        @tweet = Tweet.find_by(params[:id])
        if !params[:content].empty?
            @tweet.update(content: params[:content])
            @tweet.save
            redirect "/tweets/#{@tweet.id}"
        else
            redirect "/tweets/#{@tweet.id}/edit"
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

    



end
