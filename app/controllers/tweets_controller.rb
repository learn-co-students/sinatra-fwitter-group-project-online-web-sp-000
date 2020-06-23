class TweetsController < ApplicationController

    get '/tweets' do
        if Helpers.is_logged_in?(session)
            erb :'/tweets/index'
        else
            redirect "/login"
        end
    end

    get '/tweets/new' do
        if Helpers.is_logged_in?(session)
            erb :'/tweets/new'
        else
            redirect "/login"
        end
    end

    post '/tweets' do
        if !params[:content].empty?
            Helpers.current_user(session).tweets << Tweet.create(content: params[:content])
        else
            redirect "/tweets/new"
        end
    end

    get '/tweets/:id' do
        if Helpers.is_logged_in?(session)
            @tweet = Tweet.find_by_id(params[:id])
            erb :'/tweets/show'
        else
            redirect "/login"
        end
    end

    delete '/tweets/:id' do
        @tweet = Tweet.find_by_id(params[:id])
        if Helpers.current_user(session).id == @tweet.user_id
            @tweet.delete
        end    
        redirect "/tweets"
    end

    get '/tweets/:id/edit' do
        if Helpers.is_logged_in?(session)
            @tweet = Tweet.find_by_id(params[:id])
            erb :'/tweets/edit'
        else
            redirect '/login'
        end
    end

    patch '/tweets/:id' do
        @tweet = Tweet.find_by_id(params[:id])
        if !params[:content].empty?
            @tweet.update(content: params[:content])
            redirect "/tweets/#{@tweet.id}"
        else
            redirect "/tweets/#{@tweet.id}/edit"
        end

    end
    
end
