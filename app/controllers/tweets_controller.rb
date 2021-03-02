class TweetsController < ApplicationController

    get '/tweets' do
        @user = current_user
        if logged_in? == true
            erb :'tweets/index'
        else
            redirect '/login'
        end
    end

    get '/tweets/new' do
        @user = current_user
        if logged_in? == true
            erb :'tweets/new'
        else
            redirect '/login'
        end
    end

    post '/tweets' do
        if params[:content] != ""
            tweet = Tweet.create(content: params[:content], user_id: current_user.id)
        else
            redirect '/tweets/new'
        end
    end

    get '/tweets/:id' do
        @tweet = Tweet.find_by(id: params[:id])
        @user = current_user
        if logged_in?
            erb :'tweets/show'
        else
            redirect '/login'
        end
    end

    get '/tweets/:id/edit' do
        @tweet = Tweet.find_by(id: params[:id])
        @user = current_user
        if logged_in?
            erb :'tweets/edit'
        else
            redirect '/login'
        end
    end

    patch '/tweets/:id/edit' do
        @tweet = Tweet.find_by(id: params[:id])
        @user = current_user
        if params[:content] != ""
            @tweet.content = params[:content]
            @tweet.save 
            redirect "/tweets/#{@tweet.id}"
        else
            redirect "/tweets/#{@tweet.id}/edit"
        end
    end

    delete '/tweets/:id/delete' do
        @tweet = Tweet.find_by(id: params[:id])
        if current_user == @tweet.user
            @tweet.delete
        end
        redirect '/tweets'
    end

end
