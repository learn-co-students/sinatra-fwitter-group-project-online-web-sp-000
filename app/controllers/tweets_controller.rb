class TweetsController < ApplicationController

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/tweets" do
    if session.has_key?(:id)
      @user = User.find(session[:id])
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect to "/login"
    end
  end

  get "/tweets/new" do
    if session.has_key?(:id)
      @user = User.find(session[:id])
      erb :'tweets/new'
    else
      redirect to "/login"
    end
  end

  post "/tweets" do
    if session.has_key?(:id)
      @user = User.find(session[:id])
      @tweet = Tweet.create(content: params[:content], user_id: @user.id) unless params[:content].blank?
      redirect to "/tweets/new"
    else
      redirect to "/login"
    end
  end

  get "/tweets/:tweet_id" do
    if session.has_key?(:id)
      @user = User.find(session[:id])
      @tweet = Tweet.find(params[:tweet_id])
      erb :'tweets/show_tweet'
    else
      redirect to "/login"
    end
  end

  get "/tweets/:tweet_id/edit" do
    if session.has_key?(:id)
      @user = User.find(session[:id])
      @tweet = Tweet.find(params[:tweet_id])
      if @tweet.user_id == @user.id
        erb :'tweets/edit_tweet'
      end
    else
      redirect to "/login"
    end
  end

  patch "/tweets/:tweet_id" do
    if session.has_key?(:id)
      if params[:content].blank?
        redirect to "/tweets/#{params[:tweet_id]}/edit"
      end
      @user = User.find(session[:id])
      @tweet = Tweet.find(params[:tweet_id])
      if @tweet.user_id == @user.id
        @tweet.update(content: params[:content])
      end
      redirect to "/tweets/#{@tweet.id}/edit"
    else
      redirect to "/login"
    end
  end

  delete "/tweets/:tweet_id" do
    if session.has_key?(:id)
      @user = User.find(session[:id])
      @tweet = Tweet.find(params[:tweet_id])
      if @tweet.user_id == @user.id
        @tweet.delete
      end
    else
      redirect to "/tweets"
    end
  end


end
