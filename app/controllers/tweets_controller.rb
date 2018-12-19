class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect :'login'
    end
  end
  
  post '/tweets' do
    if logged_in?
      if params[:content] == ""
        redirect :'/tweets/new'
      end
      @tweet = Tweet.create(params)
      current_user.tweets << @tweet
    else
      redirect :'/login'
    end
  end
  
  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect to '/login'
    end
  end
  
  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect to '/login'
    end
  end
  
  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
    end
  end
end
