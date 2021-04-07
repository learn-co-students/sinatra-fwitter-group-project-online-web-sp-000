class TweetsController < ApplicationController
    get '/tweets' do
        if logged_in?
            @tweets = Tweet.all
            @user = User.find_by(username: params[:username])
            erb :'tweets/tweets'   # If a user is not logged in, it will redirect to /login.
        else
            redirect '/login'
        end
      end

    get '/tweets/new' do 
        if logged_in?
            erb :'tweets/new'
        else
            redirect '/login'
        end
    end

    post '/tweets' do 
        @tweet = Tweet.create(params)
        
        # or this: @tweet = Tweet.create(params[:tweet])
        @tweet.save
        redirect to "/tweets/#{@tweet.id}"
    end

    get '/tweets/:id' do 
        if logged_in?
            @tweet = Tweet.find(params[:id])
            erb :'tweets/show_tweet'
        else 
            redirect '/login'
        end
    end

    get '/tweets/:id/edit' do 
        if logged_in?
            erb :'tweets/edit_tweet'
        else
            redirect '/login'
        end
    end

    patch '/tweets/:id' do 
        @tweet = Tweet.find_by_id(params[:id])
        @tweet.update(params[:content])

        @tweet.save
        redirect to "/tweets/#{@tweet.id}"
    end

    delete '/tweets/:id' do
        if logged_in?
            @tweet = Tweet.find(params[:id])
            @tweet.destroy
        else
            redirect '/login'
        end
    end

end
