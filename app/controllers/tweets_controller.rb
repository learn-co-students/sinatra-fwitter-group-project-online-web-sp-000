class TweetsController < ApplicationController
  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :"/tweets/tweets"
    else
      redirect "/login"
    end
  end
  
  get '/tweets/new' do
    if logged_in?
      erb :"/tweets/new"
    else
      redirect "/login"
    end
  end
  
  post '/tweets/new' do
    if params[:content] != ""
      new_tweet = Tweet.create(content: params[:content])
      current_user.tweets << new_tweet
    else
      redirect "/tweets/new"
    end
  end
  
  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :"/tweets/show_tweet"
    else
      redirect "/login"
    end
  end
  
  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :"/tweets/edit_tweet"
    else
      redirect "/login"
    end
  end
  
  patch '/tweets/:id/edit' do
    tweet = Tweet.find(params[:id])
    tweet.content = params[:content]
    tweet.save
  end
  
  delete '/tweets/:id/delete' do
    tweet = Tweet.find(params[:id])
    if tweet.user_id == current_user.id
      tweet.delete
      redirect "/tweets"
    end
    redirect "/tweets"
  end
end