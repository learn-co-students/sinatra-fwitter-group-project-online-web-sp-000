class TweetsController < ApplicationController

    get "/tweets" do
        if logged_in?
            @users = current_user
            @tweets = Tweet.all
            erb :"/tweets/tweets"
        else
            redirect to "/login"
        end
    end

    get "/tweets/new" do
        if logged_in?
            @user = current_user
            erb :"/tweets/new"
        else
            redirect to "/login"
        end
    end

    post "/tweets" do
        @tweet = Tweet.new(params)
        @user = current_user
        if logged_in? && !@tweet.content.blank? && @tweet.save
            @user.tweets << @tweet
            redirect to "/tweets/#{@tweet.id}"  
        else
          redirect "/tweets/new" 
        end
      end
    

    get "/tweets/:id" do
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            erb :"/tweets/show"
        else
            redirect to "/login"
        end
    end

    get "/tweets/:id/edit" do
        @tweet = Tweet.find_by_id(params[:id])
        if logged_in? && @tweet.user == current_user
            erb :"/tweets/edit"
        else
            redirect to "/login"
        end
    end

    
    patch "/tweets/:id" do
        @tweet = Tweet.find_by_id(params[:id])
        if logged_in? && !params[:content].blank? && @tweet.user == current_user
            @tweet.update(content: params[:content]) 
            @tweet.save
            redirect to "/tweets/#{@tweet.id}"
        else
            redirect to "/tweets/#{@tweet.id}/edit"
        end
    end

    delete "/tweets/:id/delete" do
        @tweet = Tweet.find_by_id(params[:id])
        if logged_in? && @tweet.user == current_user
            @tweet.delete
            redirect to "/tweets"
        else
            redirect to "/login"
        end
    end
end
