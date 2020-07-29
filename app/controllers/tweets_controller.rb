class TweetsController < ApplicationController

    get '/tweets' do
        if Helpers.logged_in?(session)
            @tweets = Tweet.all
            @user = Helpers.current_user(session)
            erb :'tweets/tweets'
        else
            redirect to '/login'
        end
    end

    get '/tweets/new' do
        if Helpers.logged_in?(session)
            erb :'tweets/new'
        else
            redirect to '/login'
        end
    end

    post '/tweets' do
        if params[:content].empty?
            redirect to '/tweets/new'
        else
            id = Helpers.current_user(session).id
            @tweet = Tweet.create(content: params[:content], user_id: id)
            redirect to "/tweets/#{@tweet.id}"
        end
    end

    get '/tweets/:id' do
        if Helpers.logged_in?(session)
            @tweet = Tweet.find(params[:id])
            erb :'tweets/show_tweet'
        else
            redirect to '/login'
        end
    end

    get '/tweets/:id/edit' do
        if !Helpers.logged_in?(session)
            redirect to '/login'
        end
        @tweet = Tweet.find(params[:id])
        id = Helpers.current_user(session).id
        if @tweet.user_id == id
            erb :'tweets/edit_tweet'
        else
            redirect to "/tweets/#{@tweet.id}"
        end
    end

    patch '/tweets/:id' do
        if !params[:content].empty?
            tweet = Tweet.find(params[:id])
            tweet.update(content: params[:content])
            redirect to "/tweets/#{tweet.id}"
        else
            redirect to "/tweets/#{params[:id]}/edit"
        end
    end

    delete '/tweets/:id' do
        tweet = Tweet.find(params[:id])
        if tweet.user_id == Helpers.current_user(session).id
            tweet.destroy
            slug = Helpers.current_user(session).slug
            redirect to "/users/#{slug}"
        else
            redirect to "/tweets/#{params[:id]}"
        end
    end

end
