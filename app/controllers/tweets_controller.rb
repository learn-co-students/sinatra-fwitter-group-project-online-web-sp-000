class TweetsController < ApplicationController
  get '/tweets' do

    if logged_in?
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect to"/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/new'
    else
      redirect to"/login"
    end

  end

  post '/tweets' do
    if params[:content] != ""
      @user = User.find(session[:user_id])
      @tweet = Tweet.new(:content => params[:content])
      @tweet.user_id = @user.id
      @tweet.save
    else
      redirect to '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect to"/login"
    end
  end

  get '/tweets/:id/edit' do

    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect to"/login"
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    @tweet.update(:content => params[:content])
    if !params[:content].empty?
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to "/tweets/#{@tweet.id}/edit"
    end
  end

  delete "/tweets/:id" do
    @tweet = Tweet.find(params[:id])
    if session[:user_id] == @tweet.user_id
      Tweet.destroy(params[:id])
      redirect to "/tweets"
    else
      redirect to "/tweets/#{@tweet.id}"
    end

  end

end
