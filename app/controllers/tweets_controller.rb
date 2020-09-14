class TweetsController < ApplicationController

    get '/tweets' do
        if logged_in?
            @tweets = Tweet.all
            erb :'tweets/tweets'
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

    post 'tweets' do
    
    end

    get '/tweets/:id' do
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            erb :'tweets/show_tweet'
        else 
            redirect '/login'
        end
    end

    get '/tweets/:id/edit' do
        #binding.pry
        if !logged_in? 
            redirect '/login'
        end
        @tweet = Tweet.find(params[:id])
        if @tweet.user_id != session[:user_id]
            "You can only edit your own tweets"
            redirect '/tweets'
        else
            erb :'tweets/edit_tweet'
        end
    end

    patch '/tweets/:id' do
        tweet = Tweet.find(params[:id])
        if params["content"].empty?
          redirect to "/tweets/#{params[:id]}/edit"
        end
        tweet.update(:content => params["content"])
        tweet.save
        redirect to "/tweets/#{tweet.id}"
      end

    delete 'tweets/delete' do
        @tweet = Tweet.find(params[:id])
        if logged_in? && @tweet.user_id = session[:user_id]
            @tweet.destroy
            redirect '/tweets'
        else
            redirect '/login'
        end
    end
end
