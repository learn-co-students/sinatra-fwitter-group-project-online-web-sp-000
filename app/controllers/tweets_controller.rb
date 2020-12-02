class TweetsController < ApplicationController

    get "/tweets" do
        if !logged_in?
            redirect to '/login'
        end
        @tweets = Tweet.all
        @user = current_user
        erb :"/tweets/tweets"
    end

    get '/tweets/new' do
        if logged_in?
            erb :'/tweets/new-tweet'
        else
            redirect to '/login'
        end
    end

    post '/tweets' do
        if params[:content] == ""
            redirect to '/tweets/new'
        end
        tweet = Tweet.create(content: params[:content])
        tweet.user = current_user
        tweet.save

        redirect to '/tweets'
    end

    get "/tweets/:id" do
        @tweet = Tweet.find(params[:id])
        if logged_in?
            erb :'/tweets/show'
        else
            redirect to '/login'
        end
    end

    get "/tweets/:id/edit" do
        if logged_in?
            @tweet = Tweet.find(params[:id])
            if @tweet && @tweet.user == current_user
                erb :"/tweets/edit-tweet"
            else
                redirect to '/tweets'
            end
        else
            redirect to '/login'
        end
    end

    patch "/tweets/:id" do
        @tweet = Tweet.find(params[:id])
        if logged_in?
            if params[:content] == ""
                redirect to "/tweets/#{params[:id]}/edit"
            else
                @tweet.content = params[:content]
                @tweet.save
                redirect to "/tweets/#{@tweet.id}"
            end
        else
            redirect to '/tweets'
        end                
    end

    delete '/tweets/:id/delete' do
        @tweet = Tweet.find(params[:id])
        if logged_in? && @tweet.user == current_user
            @tweet.delete
            redirect to '/tweets'
        else
            redirect to '/login'
        end
    end

end
