class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/index'
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
    # binding.pry
    if params[:content].empty?
      redirect 'tweets/new'
    else
      @user = User.find(session[:user_id])
      @user.tweets << Tweet.create(params)
      redirect "tweets/#{@user.tweets.last.id}"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if tweet_belongs_to_user?
        erb :'tweets/edit'
      else
        redirect "/tweets/#{@tweet.id}"
      end
      
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    if params[:content].empty?
      redirect "/tweets/#{params[:id]}/edit"
    else
      @tweet = Tweet.find(params[:id])
      @tweet.update(content: params[:content])
      redirect "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/:id' do
    @tweet = Tweet.find(params[:id])

    if logged_in? && tweet_belongs_to_user?
      @tweet.delete
      redirect '/tweets'
    else
      redirect "/tweets/#{@tweet.id}"
    end

  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show'
    else
      redirect '/login'
    end
  end

  helpers do
    def tweet_belongs_to_user?
      current_user.id == @tweet.user.id
    end
  end
end
