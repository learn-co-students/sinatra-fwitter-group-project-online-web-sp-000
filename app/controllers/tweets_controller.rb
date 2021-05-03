class TweetsController < ApplicationController

    get '/tweets' do
        if logged_in?
            @user = User.find(session[:user_id])
            @tweets = Tweet.all
            erb :"/tweets/index"
        else
            redirect "/login"
        end
    end

    get '/tweets/new' do 
        if logged_in?
            @user = current_user
            erb :'/tweets/new'
        else
            redirect '/login'
        end
    end

    post '/tweets' do
        @user = current_user
        if !params[:tweet][:content].empty?
            @user.tweets.create(params[:tweet]) 
        else
            redirect '/tweets/new'
        end
    end
    
    get '/tweets/:id' do
        @tweet = find_tweet
        if logged_in?
            erb :'/tweets/show'
        else
            redirect '/login'
        end
    end

    get '/tweets/:id/edit' do 
        if logged_in? 
            if current_user.tweets.include?(find_tweet)
                @tweet = find_tweet
                erb :'/tweets/edit'
            else
                redirect "/tweets"
            end
        else
            redirect "/login"
        end
    end

    patch '/tweets/:id' do 
        tweet = find_tweet
        if !params[:tweet][:content].empty?
            tweet.update(params[:tweet])
            redirect "/tweets/#{tweet.id}"
        else
            redirect "/tweets/#{tweet.id}/edit"
        end
    end
    

    delete '/tweets/:id' do 
        binding.pry  
        if logged_in? 
            tweet = find_tweet 
            if current_user.tweets.include?(tweet)
                tweet.destroy
                p "/tweets"
            else
                p "/tweets/#{tweet.id}"
            end
        else
            p '/login'
        end
    end



end
