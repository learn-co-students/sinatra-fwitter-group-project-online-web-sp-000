class TweetsController < ApplicationController
  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if logged_in?
      if params[:content].present?
        @tweet = current_user.tweets.create(content: params[:content])
        redirect "/tweets/#{@tweet.id}"
      else
        redirect '/tweets/new'
      end
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = current_user.tweets.find_by(id: params[:id])
      if @tweet
        erb :'/tweets/edit_tweet'
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    if logged_in?
      @tweet = current_user.tweets.find_by(id: params[:id])
      if params[:content].present?
        @tweet.update(content: params[:content])
        redirect "/tweets/#{@tweet.id}"
      else
        redirect "/tweets/#{@tweet.id}/edit"
      end
    else
      redirect '/login'
    end
  end

  delete '/tweets/:id' do
    if logged_in?
      @tweet = current_user.tweets.find_by(id: params[:id])
      if @tweet
        @tweet.destroy
      end
      redirect '/tweets'
    else
      redirect '/login'
    end
  end
end