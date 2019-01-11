class TweetsController < ApplicationController

  get "/tweets" do
    if logged_in?
      @tweets = Tweet.all
      erb :"/tweets/tweets"
    else
      redirect "/login"
    end
  end

  get "tweets/show" do
    @user = current_user
    erb :"tweets/show"
  end

  get "/tweets/new" do
    if logged_in?
      erb :"/tweets/new"
    else
      redirect "/login"
    end
  end

  post "/tweets" do
    if params[:content] != ""
      @tweet = Tweet.new
      @tweet.content = params[:content]
      @tweet.user_id = session[:user_id]
      @tweet.save
      redirect "/tweets"
    else
      redirect "/tweets/new"
    end
  end

  get "/tweets/:id" do
    if logged_in?
      @tweet = Tweet.all.find(params[:id])
      erb :"/tweets/show_tweet"
    else
      redirect "/login"
    end
  end

  get "/tweets/:id/edit" do
    if logged_in? && !!current_user.tweets.map {|t| t.id}.include?(params[:id].to_i)
      @tweet = current_user.tweets.find(params[:id])
      erb :"tweets/edit_tweet"
    else
      redirect "/login"
    end
  end

  patch "/tweets/:id" do
    @tweet = current_user.tweets.find(params[:id])
    if params[:content] != ""
      @tweet.content = params[:content]
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  delete "/tweets/:id/delete" do
    @tweet_belongs_to_user = !!current_user.tweets.map {|t| t.id}.include?(params[:id].to_i)
    if logged_in? && @tweet_belongs_to_user
      current_user.tweets.find(params[:id]).destroy
      redirect "/tweets"
    else
      redirect "/login"
    end
  end
end
