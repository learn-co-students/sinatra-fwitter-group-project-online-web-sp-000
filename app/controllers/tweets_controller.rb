class TweetsController < ApplicationController

    get '/tweets/new' do
        # binding.pry
        if logged_in?
            # @tweets = Tweet.all
            erb :'/tweets/new'
        else
            redirect '/login'
        end
      end

      get '/tweets/:id/edit' do
        if logged_in?
            @tweet = Tweet.find(params[:id])
            erb :'/tweets/edit'
        else
            redirect '/login'
        end
      end

      patch '/tweets/:id/edit' do
        if logged_in?
            @tweet = Tweet.find(params[:id])
            @tweet.content = params[:content]
            @tweet.save
            erb :'/tweets/show'
        else
            redirect '/login'
        end
      end

      delete '/tweets/:id/delete' do
        if logged_in?
            @tweet = Tweet.find(params[:id])
            if @tweet.user_id == session["user_id"]
                @tweet.delete
            end
            redirect '/tweets'
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

      get '/tweets' do
        # binding.pry
        if logged_in?
            @tweets = Tweet.all
            erb :'/tweets/tweets'
        else
            redirect '/login'
        end
      end
    post '/tweets' do
        if params[:content] == ""
            redirect '/tweets/new'
        else
            @tweet = Tweet.create(content: params[:content])
            # binding.pry
            @tweet.user_id = session["user_id"]
            @tweet.save
        end
    end

end
