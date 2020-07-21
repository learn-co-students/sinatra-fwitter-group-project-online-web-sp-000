class TweetsController < ApplicationController

    get '/tweets' do
        if !logged_in?
            redirect '/login'
        end
        @tweets = Tweet.all
        @user = current_user
        erb :'tweets/tweets'
    end

    get '/tweets/new' do
        if !logged_in?
            redirect '/login'
        end
        erb :'tweets/new'
    end

    post '/tweets' do
        user = current_user
        if params[:content].empty?
            flash[:empty_tweet] = "Please endter content for your tweet"
            redirect '/tweets/new'
        end
        tweet = Tweet.create(content: params[:content], user_id: user.id)
        redirect '/tweets'
    end

    get '/tweets/:id' do
        if !logged_in?
            redirect '/login'
        end
        @user = current_user
        @tweet = Tweet.find(params[:id])
        erb :'tweets/show'
    end

    get '/tweets/:id/edit' do
        if !logged_in?
            redirect '/login'
        end
        @tweet = Tweet.find(params[:id])
        if current_user.id != @tweet.user_id
            flash[:wrong_user_edit] = "Sorry you can only edit your own tweets"
            redirect to '/tweets'
        end
        erb :'tweets/edit'
    end

    patch '/tweets/:id' do
        @tweet = Tweet.find(params[:id])
        @user = current_user
        if params[:content] == ""
            redirect "tweets/#{params[:id]}/edit"
        else
            @tweet.update(content: params[:content])
            @tweet.save
            redirect "tweets/#{params[:id]}" 
        end
    end

    post '/tweets/:id/delete' do
        @tweet = Tweet.find_by(id: params[:id])
        if current_user.id == @tweet.user_id
            @tweet.delete
            redirect '/tweets'
        else
            redirect "/tweets/#{params[:id]}"
        end
    end

end
