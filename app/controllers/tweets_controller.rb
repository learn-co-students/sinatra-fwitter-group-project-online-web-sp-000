class TweetsController < ApplicationController

    get '/tweets' do
        # binding.pry
        if logged_in?
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
        # binding.pry
        if logged_in?
            if !params[:content] == ""
                @tweet = Tweet.new(content: params[:content])
                @tweet.save
                @tweet.user = current_user
            else 
                redirect '/tweets/new'
            end
        else
            redirect '/login'
        end
    end




end
