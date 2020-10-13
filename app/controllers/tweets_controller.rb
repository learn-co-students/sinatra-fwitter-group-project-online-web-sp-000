class TweetsController < ApplicationController
    get '/tweets' do
        redirect '/login' if !is_logged_in?
        @user = current_user
        erb :'/tweets/tweets'
        #correction: it looks like it wants ALL tweets, not just your own tweets.
        #like a newsfeed
    end

    get '/tweets/new' do
        redirect '/login' if !is_logged_in? 
        erb :'/tweets/new'
    end

    post '/tweets' do
        if !params[:content].empty?
            tweet = Tweet.new(content: params[:content])
            tweet.save
            user = current_user
            user.tweets << tweet
            user.save
            redirect "/tweets/#{tweet.id}"
        else
            redirect '/tweets/new'
        end
    end

    get '/tweets/:id' do
        redirect '/login' if !is_logged_in? 
        @tweet = Tweet.find_by(id: params[:id])
        erb :'/tweets/show_tweet'
    end

    get '/tweets/:id/edit' do
        redirect '/login' if !is_logged_in? 
        @tweet = Tweet.find_by(id: params[:id])
        if current_user.id != @tweet.user_id
            redirect "/tweets/#{params[:id]}"
        else
            erb :'/tweets/edit_tweet'
        end
    end

    patch '/tweets/:id' do
        #process edit
        redirect "/tweets/#{params[:id]}/edit" if params[:content].empty?
        #otherwise, update and redirect to show that tweet
        tweet = Tweet.find_by(id: params[:id])
        tweet.update(content: params[:content])
        tweet.save
        redirect "/tweets/#{params[:id]}"
    end


    delete '/tweets/:id/delete' do
        redirect '/login' if !is_logged_in? 
    
        tweet = Tweet.find_by(id: params[:id])
        if tweet && current_user.id == tweet.user_id
                tweet.delete
        end

        #if tweet is found or not, after we delete the tweet, we go here
        redirect '/tweets'
    end



end
