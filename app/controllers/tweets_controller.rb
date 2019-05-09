class TweetsController < ApplicationController

    get '/tweets/new' do
      if logged_in?
        @user = current_user
        erb :"tweets/new"
      else
        redirect '/login'
      end
    end

    post '/tweets' do
      if params[:content].empty?
        redirect '/tweets/new'
      else
        @tweet = Tweet.create(content: params[:content])
        @tweet.user = current_user
        @tweet.save
        redirect "/tweets"
      end
    end

    get '/tweets' do
      if logged_in?
        @tweets = Tweet.all
        @user = current_user
        erb :"tweets/tweets"
      else
        redirect '/login'
      end
    end

    get '/tweets/:id' do
      if logged_in?
        @tweet = Tweet.find(params[:id])
        erb :"tweets/show_tweet"
      else
        redirect '/login'
      end
    end

    get '/tweets/:id/edit' do
      if logged_in?
        @tweet = Tweet.find(params[:id])
        erb :"tweets/edit_tweet"
      else
        redirect '/login'
      end
    end

    patch '/tweets/:id' do
      if params[:content].empty?
        redirect "/tweets/#{params[:id]}/edit"
      else
        @tweet = Tweet.find(params[:id])
        @tweet.update(content: params[:content])
        redirect "/tweets/#{@tweet.id}"
      end
    end

    delete '/tweets/:id' do
      @tweet = Tweet.find(params[:id])

      if @tweet.user.id == current_user.id
        @tweet.delete
        redirect '/tweets'
      else
        redirect '/tweets'
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
