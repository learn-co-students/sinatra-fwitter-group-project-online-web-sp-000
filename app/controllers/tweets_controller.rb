class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect to "/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    if logged_in?
      @tweet = Tweet.create(params[:tweet])
      redirect to "tweets/#{@tweet.id}"
    else
      redirect to '/login'
    end
  end

  get 'tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  get 'tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'edit/tweet'
    else
      redirect to '/login'
    end
  end

  patch 'tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      @tweet.update(params[:tweet])
      @tweet.content = params[:tweet]
      @tweet.save
      redirect to "/tweet/#{@tweet.id}"
    else
      redirect to '/login'
    end
  end

  delete '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      @tweet.delete
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end

end
