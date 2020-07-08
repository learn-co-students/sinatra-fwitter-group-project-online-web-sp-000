class TweetsController < ApplicationController
    get '/tweets' do
        if Helpers.is_logged_in?(session)
            @tweets = Tweet.all
            erb :'/tweets/tweets'
        else
            redirect to '/login'
        end
    end

    get '/tweets/new' do
        if Helpers.is_logged_in?(session)
            erb :'/tweets/new'
        else
            redirect to '/login'
        end
    end

    get '/tweets/:id' do
        if Helpers.is_logged_in?(session)
            @tweet = Tweet.find(params[:id])
            erb :'/tweets/show'
        else
            redirect to '/login'
        end
    end

    get '/tweets/:id/edit' do
        if Helpers .is_logged_in?(session) && Helpers.current_user(session) == Tweet.find(params[:id]).user
            @tweet = Tweet.find(params[:id])
            erb :'/tweets/edit'
        else
            redirect to '/login'
        end
    end

    post '/tweets' do
        if params[:content].empty?
            redirect to '/tweets/new'
        else
            tweet = Tweet.new
            tweet.content = params[:content]
            tweet.user = Helpers.current_user(session)
            tweet.save
            redirect to "/tweets/#{tweet.id}"
        end
    end

    patch '/tweets/:id' do
        if !params[:content].empty?
            tweet = Tweet.find(params[:id])
            tweet.content = params[:content]
            tweet.user = Helpers.current_user(session)
            tweet.save
            redirect to "/tweets/#{tweet.id}"
        else
            redirect to "/tweets/#{params[:id]}/edit"
        end
    end

    delete '/tweets/:id' do
        if Helpers.current_user(session) == Tweet.find(params[:id]).user
            Tweet.delete(params[:id])
            redirect to "/"
        else
            redirect to "/tweets/#{params[:id]}/edit"
        end
    end
end
