class TweetsController < ApplicationController
  get '/tweets' do
    redirect '/login' unless is_logged_in?

    @user = current_user
    @tweets = Tweet.all
    erb :'/tweets/index'
  end

  post '/tweets' do
    redirect '/login' unless is_logged_in?

    tweet = Tweet.new(user: current_user, content: params[:content])
    if tweet.save
      redirect '/tweets'
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/new' do
    redirect '/login' unless is_logged_in?

    @user = current_user
    erb :'/tweets/new'
  end

  get '/tweets/:id' do
    redirect '/login' unless is_logged_in?

    @tweet = Tweet.find(params[:id])
    erb :'/tweets/show'
  end

  put '/tweets/:id' do
    redirect '/login' unless is_logged_in?

    tweet = Tweet.find(params[:id])
    redirect '/tweets' unless current_user.id == tweet.user.id

    tweet.content = params[:content]
    if tweet.save
      redirect "/tweets/#{tweet.id}"
    else
      redirect "/tweets/#{tweet.id}/edit"
    end
  end

  delete '/tweets/:id' do
    redirect '/login' unless is_logged_in?

    tweet = Tweet.find(params[:id])
    redirect '/tweets' unless current_user.id == tweet.user.id

    tweet.delete
    redirect '/tweets'
  end

  get '/tweets/:id/edit' do
    redirect '/login' unless is_logged_in?

    @tweet = Tweet.find(params[:id])
    erb :'/tweets/edit'
  end
end
