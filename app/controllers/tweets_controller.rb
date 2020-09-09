class TweetsController < ApplicationController
    get '/tweets' do
        if logged_in?
            @tweets = Tweet.all
            @user = User.find(session[user_id])
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

    post '/tweets' do
        tweet = Tweet.new(params)
        if tweet.save
            redirect "/tweets/#{tweet.id}"
        else
            redirect '/tweets/new'
        end

    end

    get '/tweets/:id' do
        if logged_in?
            erb :'tweets/show_tweet'
        else
            redirect '/login'
        end
    end

    get '/tweets/:id/edit' do
        if logged_in?
            erb :'tweets/edit_tweet'
        else
            redirect '/login'
        end
    end

    patch '/tweets/:id' do
        tweet = Tweet.update(params)
        redirect "/tweets/#{tweet.id}"

    end


end
