class TweetsController < ApplicationController

  get '/tweets' do
    redirect '/login' if !logged_in?
    @user = User.find(session[:user_id])
    @tweets = Tweet.all
    erb :'tweets/index'
  end

  get '/tweets/new' do
    redirect '/login' if !logged_in?
    @user = User.find(session[:user_id])
    erb :'tweets/new'
  end

  post '/tweets' do
    redirect 'tweets/new' if params[:content] == ""
    @user = User.find(session[:user_id])
    @tweet = @user.tweets.create(content: params[:content])
    redirect '/tweets'
  end

  get '/tweets/:id' do
    redirect 'login' if !logged_in?
    @tweet = Tweet.find_by_id(params[:id])
    erb :'tweets/show'
  end

  get '/tweets/:id/edit' do
    redirect 'login' if !logged_in?
    @tweet = Tweet.find_by_id(params[:id])
    erb :'tweets/edit'
  end

  patch '/tweets/:id' do
    redirect "tweets/#{params[:id]}/edit" if params[:content] == ""
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.update(content: params[:content])
    redirect "tweets/#{@tweet.id}"
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if current_user == @tweet.user
      @tweet.destroy
    end
    redirect '/tweets'
  end

end
