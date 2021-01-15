class TweetsController < ApplicationController

    get '/tweets' do
        if logged_in?
            erb :'/tweets/index'
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
    
    post '/tweets' do
        if logged_in?
            if params[:content] == ""
                redirect '/tweets/new'
            else
                @tweet = current_user.tweets.create(content: params[:content])
                redirect "/tweets/#{@tweet.id}"
            end
        else
            redirect '/login'
        end
    end

    get '/tweets/:id' do
        if logged_in?
            @tweet = Tweet.find(params[:id])
            erb :'/tweets/show'
        else
            redirect '/login'
        end
    end

    get '/tweets/:id/edit' do
        if logged_in?
            @tweet = Tweet.find(params[:id])
            if @tweet && @tweet.user == current_user
                erb :'/tweets/edit'
            else
                redirect '/tweets'
            end
        else
            redirect '/login'
        end
    end

    patch '/tweets/:id' do
        if logged_in?
            if params[:content] == ""
                redirect "/tweets/#{params[:id]}/edit"
            else
                @tweet = Tweet.find(params[:id])
                if @tweet && @tweet.user == current_user
                    if @tweet.update(content: params[:content])
                        redirect "/tweets/#{@tweet.id}"
                    else
                        redirect "/tweets/#{@tweet.id}/edit"
                    end
                else
                    redirect '/tweets'
                end
            end
        else
            redirect '/login'
        end
    end

    delete '/tweets/:id/delete' do
        if logged_in?
            @tweet = Tweet.find(params[:id])
            if @tweet && @tweet.user == current_user
                @tweet.destroy
            end
            redirect '/tweets'
        else
            redirect '/login'
        end
    end
end
