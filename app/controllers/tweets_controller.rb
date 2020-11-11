require "pry"

class TweetsController < ApplicationController
  get "/tweets" do
    if logged_in?
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect "/login"
    end
  end

  get "/tweets/new" do
    if logged_in?
      @tweets = Tweet.all
      erb :'/tweets/new'
    else
      redirect "/login"
    end
  end

  get "/tweets/:id" do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect "/login"
    end
  end

  post "/tweets" do
    if logged_in? && params[:content] != ""
      @user = current_user
      @tweet = Tweet.create(content: params[:content])
      @user.tweets << @tweet
      redirect to "/tweets/#{@tweet.id}"
    elsif !logged_in?
      redirect "/users/login"
    elsif params[:content] == ""
      redirect "/tweets/new"
    end
  end

  get "/tweets/:id/edit" do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      @users = User.all
      erb :'/tweets/edit_tweet'
    else
      redirect "/login"
    end
  end

  patch "/tweets/:id" do
    if logged_in? && params[:content] != ""
      @tweet = Tweet.find_by(id: params[:id])

      @tweet.update(content: params[:content])
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    elsif params[:content] == ""
      @tweet = Tweet.find_by(id: params[:id])
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  delete "/tweets/:id/delete" do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      if current_user.tweets.include?(@tweet)
        @tweet.delete
        redirect "/"
      end
    else
      erb :'/users/login'
    end
  end
end
