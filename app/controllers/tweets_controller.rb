class TweetsController < ApplicationController
    enable :sessions

    get '/tweets' do
        if Helpers.is_logged_in?(session)
            @user = Helpers.current_user(session)
            session[:user_id] = @user.id
            erb :'/tweets/index'
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
            @user = Helpers.current_user(session)
            @user.tweets.create(params)
            redirect to '/tweets'
        else
            redirect to '/tweets/new'
            flash[:message] = "Please type something to Fleet!"
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
        if Helpers.is_logged_in?(session)
            @tweet = Tweet.find(params[:id])
            erb :'/tweets/edit'
        else
            redirect to '/login'
        end
    end

    patch '/tweets/:id/edit' do
        @tweet = Tweet.find(params[:id])

        if params[:content] != ""
            # @user = Helpers.current_user(session)
            # @user.tweets.create(params)
            @tweet.update(:content => params[:content])
            redirect to '/tweets'
        else
            redirect to "/tweets/#{@tweet.id}/edit"
            flash[:message] = "Please type something to Fleet!"
        end
    end


end
