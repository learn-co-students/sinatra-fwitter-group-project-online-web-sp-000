class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all

      erb :"/tweets/index"
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      @user = current_user

      erb :"/tweets/new"
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])

      erb :"/tweets/show"
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])

      if current_user.tweets.include?(@tweet)
        erb :"/tweets/edit"
      else
        redirect '/login'
      end
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if !params["tweet"]["content"].empty?
      tweet = Tweet.create(content: params["tweet"]["content"], user_id: current_user.id)
      redirect "/tweets/#{tweet.id}"
    else
      redirect "/tweets/new"
    end
  end

  patch '/tweets/:id' do
    if !params["tweet"]["content"].empty?
      Tweet.find(params[:id]).update(params["tweet"])
      redirect "/tweets/#{params[:id]}"
    else
      redirect "/tweets/#{params[:id]}/edit"
    end
  end

  delete '/tweets/:id' do
    if logged_in?
      tweet = Tweet.find(params[:id])

      if current_user.tweets.include?(tweet)
        tweet.destroy
        redirect '/tweets'
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end
end
