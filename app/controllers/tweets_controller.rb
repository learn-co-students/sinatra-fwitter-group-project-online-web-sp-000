class TweetsController < ApplicationController
  
    get '/tweets' do
        if Helpers.is_logged_in?(session)
            @user = Helpers.current_user(session)
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

    post '/tweets' do
        if params[:content] != ""
            user = User.find(session[:user_id])
            user.tweets << Tweet.new(content: params[:content])
            user.save
        else
            redirect to "/tweets/new"
        end
    end

    get '/tweets/:id' do
        if Helpers.is_logged_in?(session)
            @tweet = Tweet.find(params[:id])
            erb :'/tweets/show_tweet'
        else
            redirect to '/login'
        end
    end

    get '/tweets/:id/edit' do
        if Helpers.is_logged_in?(session)
            @tweet = Tweet.find(params[:id])
            erb :'/tweets/edit_tweet'
        else
            redirect to '/login'
        end
    end

    patch '/tweets/:id' do
        @tweet = Tweet.find(params[:id])
        @user = @tweet.author
        if @user == Helpers.current_user(session) && !params[:content].empty?
            @tweet.content = params[:content]
            @tweet.save
            redirect to "/tweets/#{@tweet.id}"
        else
            redirect to "/tweets/#{params[:id]}/edit"
        end
    end

    post '/tweets/:id/delete' do
        @tweet = Tweet.find(params[:id])
        @user = @tweet.author
        if @user == Helpers.current_user(session)
            @tweet.delete
            redirect to '/tweets'
        else
            redirect to "/tweets/#{@tweet.id}"
        end
    end

end
