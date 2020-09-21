class TweetsController < ApplicationController

    get '/tweets' do
        if logged_in?
            @tweets = Tweet.all
            erb :'/tweets/all'
        else
            redirect to '/login'
        end
    end
    
    get '/tweets/new' do
        if logged_in?
            erb :"/tweets/new"
        else
            redirect to '/login'
        end
    end

    post "/tweets/new" do
        @user = current_user
        @tweet = Tweet.create(content: params[:content], user: @user)
        
        if @tweet.save
            redirect to "/users/#{@user.slug}"
        else
            redirect to '/tweets/new'
        end
    end

    get "/tweets/:id" do
        if logged_in?
            @tweet = Tweet.find(params[:id])
            erb :'/tweets/show_tweet'
        else
            redirect to "/login"
        end
    end

    get "/tweets/:id/edit" do
        @tweet = Tweet.find(params[:id])
        if logged_in?
            erb :'/tweets/edit_tweet'
        else
            redirect to '/login'
        end
    end

    patch "/tweets/:id" do
        @tweet = Tweet.find(params[:id])
        @user = current_user
        if @tweet.update(content: params[:content], user: @user)
            redirect to "/tweets/#{@tweet.id}"
        else
            redirect to "/tweets/#{@tweet.id}/edit"
        end
    
    end

    delete "/tweets" do
    end

end
