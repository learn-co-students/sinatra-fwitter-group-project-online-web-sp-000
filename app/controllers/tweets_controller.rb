class TweetController < ApplicationController

  # Index Action
  get '/tweets' do
    if session[:id] 
      @user = User.find(session[:id])
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end
  
  # New Action
  get '/tweets/new' do
    if session[:id] 
      @users = User.all
    erb :'/tweets/new'
    else
      redirect '/login'
    end
  end
  
  # Create Action
  post '/tweets' do
    tweet = Tweet.create(params['tweet'])
    tweet.user = User.create(name: params['user_name']) unless params['user_name'].empty?

    tweet.save
    redirect "tweets/#{tweet.id}"
  end
  
  # Show Action
  get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/show'
  end
  
  # Edit Action
  get '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    @users = User.all
    erb :'/tweets/edit'
  end
  
  # Patch Action
  patch '/tweets/:id' do

    tweet = Tweet.find(params[:id])
    tweet.update(params['tweet'])
    tweet.user = User.create(name: params['user_name']) unless params['user_name'].empty?

    tweet.save
    redirect "tweets/#{tweet.id}"
  end
  
  # Delete Action
  delete '/tweets/:id' do
    tweet = Tweet.find(params[:id])
    tweet.delete
  end
  
end