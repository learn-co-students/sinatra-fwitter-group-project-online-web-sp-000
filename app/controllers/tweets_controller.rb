class TweetsController < ApplicationController

    configure do
        enable :session
        set :session_secret, "secret"
    end

    get '/tweets' do
        if logged_in?
            @users = current_user
            @tweets = Tweet.all 
            erb :'/tweets/tweets' 
        end
    end

    get '/tweets/new' do
        if logged_in?
            @users = current_user
            erb :'/tweets/create_tweet'
        else
            redirect "/login"
        end
    end

    post '/tweets' do
        @tweet = Tweet.new(content: params[:content], user: current_user)
        # @users = current_user
        if logged_in? && @tweet.save
            @user.tweets << @tweet
            redirect to "/tweets/#{@tweet.id}"
        else
            redirect to "/tweets/new"
        end
    end

    get '/tweets/:id' do
        if logged_in?
            @tweets = Tweet.find_by_id(params[:id])
            @user = current_user
            erb :'/tweets/show_tweet'
        else
            redirect to "/login"
        end
    end

    get '/tweets/:id/edit' do
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id])
                if @tweet && @user == current_user
                    erb :'/tweets/edit_tweet'
                else
                    redirect to "/tweets"
                end
        else
            redirect to "/login"
        end
    end

    patch '/tweets/:id' do
        if logged_in?
            if params[:content] == ""
                redirect to "/tweets/#{params[:id]}/edit"
            else
            @tweet = Tweet.find_by_id(params[:id])
                if @tweet = @tweet.user == current_user
                    if @tweet.update(content: params[:content])
                        redirect to "/tweets/#{tweet.id}"
                    else
                        redirect to "tweets/#{tweet.id}/edit"
                    end
                else
                    redirect to "/tweets"
                end
            end
        else
            redirect to "/login"
        end

    end

    delete '/tweets/:id/delete' do
        if logged_in?
        @tweet = current_user.tweets.find_by_id(params[:id])
            if tweet && tweet.delete
                redirect to "/tweets"
            else
                redirect to "/tweets/#{tweet.id}"
            end
        else
            redirect to "/login"
        end
    end

end
