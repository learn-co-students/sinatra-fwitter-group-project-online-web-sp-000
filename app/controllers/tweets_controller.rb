class TweetsController < ApplicationController
  get "/tweets" do
    if logged_in? == false
      erb :'/users/login'
    else
      @tweets = Tweet.all
      erb :'/tweets/index'
    end
  end

  get "/tweets/new" do
    @tweets = Tweet.all
    erb :'/tweets/new'
  end

  get "/tweets/:id" do
    @tweet = Tweet.find_by_id(params[:id])
    erb :'/tweets/show'
  end

  post "/tweets" do
    @tweet = Tweet.create(params[:tweet])
    redirect to "tweets/#{@tweet.id}"
  end

  get "/tweets/:id/edit" do
    @tweet = Tweet.find_by(params[:id])
    @users = User.all
    erb :'/tweets/edit_tweet'
  end

  post "/tweets/:id" do
    @tweet = Tweet.find_by(params[:id])
  end
end
