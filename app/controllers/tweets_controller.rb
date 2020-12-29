class TweetsController < ApplicationController

    configure do
        set :views, "app/views"
		enable :sessions
		set :session_secret, "password_security"
    end

    get '/tweets' do
        #binding.pry
        if Helpers.is_logged_in?(session)
            erb :'index'
        else
            redirect to "/login"
        end
        
    end

    get '/tweets/new' do
        @error = ""
        #binding.pry
        if logged_in?
            #binding.pry
            erb :'/tweets/new'
        else
            redirect to "/login"
        end
    end

    post '/tweets' do


        @user = User.find(session[:user_id])
        @tweet = Tweet.create(content: params[:content], user_id: @user.id)

        if @tweet.content == ""
            redirect to "/tweets/new"
        end

        redirect to "/tweets"
    end

    get '/tweets/:id' do
        if Helpers.is_logged_in?(session)
            @tweet = Tweet.find(params[:id])
            @error = ""
            
            erb :'tweets/show'
        else
            redirect to "/login"
        end
        
        
    end

    get '/tweets/:id/edit' do
        if Helpers.is_logged_in?(session)

            @tweet = Tweet.find(params[:id])

            erb :'/tweets/edit'
        else
            redirect to "/login"
        end
    end

    patch '/tweets/:id' do
        @tweet = Tweet.find(params[:id])
        @tweet.update(content: params[:content])

        redirect to "/tweets/#{@tweet.id}/edit"
    end

    delete '/tweets/:id' do
        #binding.pry
        @tweet = Tweet.find(params[:id])

        if @tweet.user_id == session[:user_id]
            
            @tweet.delete
            erb :'tweets/delete'
        else
            redirect to "/tweets/#{@tweet.id}"
        end
    end

    helpers do
        def logged_in?
          !!session[:user_id]
        end
    
        def current_user
          User.find(session[:user_id])
        end
    end
end
