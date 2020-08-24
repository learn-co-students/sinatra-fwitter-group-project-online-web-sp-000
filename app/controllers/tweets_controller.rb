class TweetsController < ApplicationController

    
    get "/tweets/new" do
        if logged_in?
            erb :"/tweets/new"
        else
            redirect "/login"
        end
    end
    
    post "/tweets/new" do
        if logged_in? && params[:content] != ""
            @tweet = Tweet.create(:content => params[:content], :user => current_user)
            redirect "/tweets/#{@tweet.id}"
        else
            redirect "/tweets/new"
        end
    end

    get "/tweets/:id/edit" do
        @tweet = Tweet.all.find_by_id(params[:id])

        if logged_in? && current_user.tweets.include?(@tweet)
            erb :"/tweets/edit_tweet"
        else
            redirect "/login"
        end
    end

    delete "/tweets/:id" do
        @tweet = Tweet.find_by_id(params[:id])
        if logged_in? && current_user.tweets.include?(@tweet)
            @tweet.destroy
            redirect to("/tweets")
        else
            redirect "/tweets/#{params[:id]}"
        end

    end


    patch "/tweets/:id" do
        @tweet = Tweet.find_by_id(params[:id])
        if params[:content] != ""
            @tweet.update(:content => params[:content])
            redirect to("/tweets/#{@tweet.id}")
        else
            redirect to("/tweets/#{@tweet.id}/edit")
        end
    end
    
    

    get "/tweets/:id" do
        if logged_in?
            @tweet = Tweet.all.find_by_id(params[:id])
            erb :"/tweets/tweet"
        else
            redirect "/login"
        end
    end

    get "/tweets" do
        if logged_in?
            @user = current_user
            erb :"/tweets/index"
        else
            redirect to("/login")
        end
    end
end
