class TweetsController < ApplicationController

    get '/tweets' do 
        if @user = current_user(session)
        # binding.pry
            @tweets = Tweet.all
            @users = User.all
            erb :'tweets/tweets'
        else
            redirect to "/login"
        end
    end

    get '/tweets/new' do
        erb :'/tweets/new'
    end

    post '/tweets' do
        @tweet = Tweet.create(params[:content])
        redirect to "/tweets/#{@tweet.id}"
    end

    get '/tweets/:id' do
        @tweet = Tweet.find_by_id(params[:id])
        erb :'/tweets/show'
    end

    get '/tweets/:id/edit' do

    end

    patch '/tweets/:id/edit' do

    end

    get '/tweets/:id/delete' do

    end
end
