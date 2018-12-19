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
  
  
  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect :'/login'
    end
  end
  
  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/edit_tweet'
    else
      redirect :'users/login'
    end
  end
  
  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect :'/login'
    end
  end
  
  patch '/tweets/:id' do
    if logged_in?
      if params[:content] == ""
        redirect :"/tweets/#{params[:id]}/edit"
      end
      @tweet = Tweet.find(params[:id])
      @tweet.update(content: params[:content])
      redirect :"/tweets/#{@tweet.id}"
    else
      redirect :'users/login'
    end
  end
  
  delete '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if current_user.id == @tweet.user.id
        @tweet.destroy
        redirect :"/tweets"
      end
    else
      redirect :'users/login'
    end
  end
end
