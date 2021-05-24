class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/new'
    else
      redirect to "/login"
    end
  end

  post '/tweets' do
    if logged_in? && params[:content] != ""
      @user = current_user
      @tweet = Tweet.create(content: params[:content])
      @user.tweets << @tweet
      redirect to "/tweets/#{@tweet.id}"
    elsif !logged_in?
      redirect to '/login'
    elsif params[:content] = ""
      redirect to '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      if @tweet && @tweet.user == current_user
        erb :"/tweets/edit_tweet"
      else
        redirect to '/tweets'
    end
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    @user = User.find{|user| user.id == session[:user_id]}
    @tweet = Tweet.find_by(id: params[:id])
    if @user.tweets.include?(@tweet)
      if params[:content] != ""
        @tweet.update(content: params[:content])
        redirect to "/tweets/#{@tweet.id}"
      else
        redirect to "/tweets/#{@tweet.id}/edit"
      end
    else
      redirect to '/tweets'
    end
  end

  delete '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if @tweet.user == User.find{|user| user.id == session[:user_id]}
        @tweet.delete
      else
        redirect to '/tweets'
      end
    else
      redirect '/login'
    end
  end
end
