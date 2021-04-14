class TweetsController < ApplicationController

  get '/tweets' do
    if defined?(current_user) && logged_in?
      @tweets = Tweet.all
      erb :"/tweets/tweets"
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    if defined?(current_user) && logged_in?
     erb :"tweets/new"
    else
     redirect "/login"
    end
  end

  post '/tweets' do
    @tweet = current_user.tweets.create(content: params[:content])
    redirect "/tweets/#{@tweet.id}"
  end

  get '/tweets/:id' do
    if defined?(current_user) && logged_in?
      @tweet = Tweet.find(params[:id])
      erb :"tweets/show_tweet"
    else
      redirect "/login"
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    if defined?(current_user) && logged_in? && @tweet.user_id == current_user.id
      erb :"tweets/edit_tweet"
    else
      redirect "/tweets/#{@tweet.id}"
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    @tweet.update(content: params[:content])
    redirect "/tweets/#{@tweet.id}"
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if defined?(current_user) && logged_in? && @tweet.user_id == current_user.id
      @tweet.delete
      redirect "/tweets"
    else
      redirect "/tweets/#{@tweet.id}"
    end
  end

end
