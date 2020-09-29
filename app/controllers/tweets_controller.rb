class TweetsController < ApplicationController

    get '/tweets' do
        if logged_in?
            @tweets = Tweet.all
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

    post '/tweets/new' do
        @user = current_user
        if params[:content] == ""
            redirect '/tweets/new'
        else
            @tweet = Tweet.create(content: params[:content], user: @user)
            redirect "/users/#{@user.slug}"
        end
    end

    get "/tweets/:id" do
        if logged_in?
            @tweet = Tweet.find_by(id: params[:id])
            erb :'/tweets/show_tweet'
        else
            redirect '/login'
        end
    end

    get "/tweets/:id/edit" do
        if logged_in?
            @tweet = Tweet.find_by(id: params[:id])
            erb :'/tweets/edit_tweet'
        else
            redirect '/login'
        end
    end

    patch '/tweets/:id' do
        @tweet = Tweet.find_by(id: params[:id])
        if params[:content] == ""
            redirect "/tweets/#{@tweet.id}/edit"
        elsif logged_in?
            @tweet.update(content: params[:content])
            @tweet.save
            redirect "/tweets/#{@tweet.id}"
        else
            redirect '/login'
        end
    end

    delete '/tweets/:id' do
        @tweet = Tweet.find_by(id: params[:id])
        if logged_in? && current_user.id == @tweet.user_id
            @tweet.destroy
            redirect '/tweets'
        else
            redirect "/tweets/#{@tweet.id}"
        end
    end
end
