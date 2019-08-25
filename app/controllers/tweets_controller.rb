class TweetsController < ApplicationController

  get '/tweets' do
    if !!logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if params[:content] == ""
      redirect 'tweets/new'
    end
    user = current_user
    user.tweets.create(content: params[:content])
    user.save
  end

  get '/tweets/:id' do
    if !!logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if !!logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if params[:content] == ""
      redirect "/tweets/#{@tweet.id}/edit"
    elsif current_user.id == @tweet.user_id
      @tweet.update(content: params[:content])
      redirect "/tweets/#{@tweet.id}"
    else
      redirect '/login'
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if current_user.id == @tweet.user_id
      @tweet.destroy
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

end
