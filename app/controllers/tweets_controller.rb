class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :"/tweets/index"
    else
      redirect :'/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :"/tweets/new"
    else
      redirect :'/login'
    end
  end

  post '/tweets' do
    @tweet = Tweet.create(params)
    @tweet.user_id = current_user.id
    redirect "/tweets/#{@tweet.id}"
  end

  get '/tweets/:id/edit' do
    if logged_in?
      erb :"/tweets/edit_tweet"
    else
      redirect :'/login'
    end
  end

  patch '/tweets' do
    @tweet = Tweet.find(params[:id])
    @tweet.uptdate(params)
    @tweet.save

    redirect "/tweets/#{@tweet.id}"
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      erb :"/tweets/show_tweet"
    else
      redirect :'/login'
    end
  end

  delete '/tweets/:id' do
    if logged_in? && params[:id] == current_user.id
      @tweet = Tweet.find(params[:id])
      @tweet.destroy
      redirect '/tweets'
    else
      redirect :'/login'
    end
  end

end
