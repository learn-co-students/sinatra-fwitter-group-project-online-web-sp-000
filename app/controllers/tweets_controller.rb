class TweetsController < ApplicationController

    get '/tweets' do
        @tweets = Tweet.all
        if logged_in?
            erb :'tweets/tweets'
        else 
             redirect to "/login"
        end 
    end

    get '/tweets/new' do
        if logged_in?
          erb :'tweets/new'
        else
            redirect to '/login'
        end
    end

    get '/tweets/:id' do
        if logged_in?
             @tweet = Tweet.find_by(id: params[:id])
             erb :'tweets/show_tweet'
        else 
            redirect to '/login'
        end 
    end

    post '/tweets' do
        if params[:content] == ""
            redirect to '/tweets/new'
        else
             @tweet = Tweet.create(content: params[:content])
             @tweet.user = current_user
             @tweet.save
            redirect to "/tweets/#{@tweet.id}"
        end 
    end 

    get '/tweets/:id/edit' do
        if logged_in?
            @tweet = Tweet.find_by(id: params[:id])
            if @tweet && @tweet.user == current_user 
                erb :'tweets/edit_tweet'
            else
                redirect to '/tweets'
            end 
        else 
            redirect to '/login'
        end
    end

    patch '/tweets/:id' do
        @tweet = Tweet.find_by(id: params[:id])
        if params[:content] != ""
            @tweet.update(content: params[:content])
            redirect to "/tweets/#{@tweet.id}"
        else 
            redirect to "/tweets/#{@tweet.id}/edit"
        end 
    end

    delete '/tweets/:id/delete' do
        @tweet = Tweet.find_by(id: params[:id])
        if @tweet.user_id == current_user.id 
            @tweet.delete
            redirect to "/tweets"
        else 
            redirect to '/login'
        end 
    end



end
