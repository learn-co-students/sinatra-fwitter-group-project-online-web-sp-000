class TweetsController < ApplicationController
    get '/tweets/new' do
        if (logged_in? == true)
            erb :'/tweets/new'
        else
            redirect '/users/login'
        end
    end

    post '/tweets' do
        tweet = Tweet.new(content: params[:content], user_id: current_user.id)
        if (params[:content] == "" || logged_in? == false)
            redirect '/tweets/failure'
        elsif (tweet.save)
            redirect '/tweets'
        end
    end

    get '/tweets' do
        if (logged_in? == true)
            @tweets = Tweet.all
            erb :'/tweets/index'
        else
            redirect '/users/login'
        end
    end

    get '/tweets/:id/edit' do
        @tweet = Tweet.find(params[:id])
        if (logged_in? == true && current_user.id == @tweet.user_id)
            erb :'/tweets/edit'
        elsif (logged_in? == false)
            redirect '/users/login'
        else
            redirect '/tweets/failure' 
        end
    end

    patch '/tweets/:id' do
        tweet = Tweet.find(params[:id])
        if (logged_in? == true && current_user.id == tweet.user_id)
            tweet.content = params[:content]
            tweet.save
            redirect '/tweets'
        elsif (logged_in? == false)
            redirect '/users/login'
        else
            redirect '/tweets/failure' 
        end
    end

    delete '/tweets/:id' do
        tweet = Tweet.find(params[:id])
        if (logged_in? == true && current_user.id == tweet.user_id)
            tweet.delete
            redirect '/tweets'
        elsif (logged_in? == false)
            redirect '/users/login'
        else
            redirect '/tweets/failure' 
        end
    end

    get '/tweets/:id' do
        @tweet = Tweet.find(params[:id])
        if (logged_in? == true && current_user.id == @tweet.user_id)
            erb :'/tweets/show'
        elsif (logged_in? == false)
            redirect '/users/login'
        else
            redirect '/users/failure' 
        end
    end

    get '/tweets/failure' do
        erb :'/tweets/failure'
    end
end
