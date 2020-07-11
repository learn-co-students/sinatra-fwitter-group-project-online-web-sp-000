class TweetsController < ApplicationController

  get '/tweets' do
    if session[:id] == nil
      redirect to '/login'
    else
      @user = User.find(session[:id])
      erb :'/tweets/index'
    end
  end

  get '/tweets/new' do
    if session[:id] == nil
      redirect to '/login'
    else
      @user = User.find(session[:id])
      erb :'/tweets/new'
    end
  end

  post '/tweets' do
    @user = User.find(session[:id])

    if params[:content] != ""
      @tweet = Tweet.create(content: params[:content])
      @user.tweets << @tweet
      @user.save
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if session[:id] != nil
      @user = User.find(session[:id])
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if session[:id] == nil
      redirect to '/login'
    else
      @user = User.find(session[:id])
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/edit'
    end
  end

  patch '/tweets/:id' do
    @user = User.find(session[:id])
    @tweet = Tweet.find(params[:id])

    if params[:content] != ""
      @tweet.content = params[:content]
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id' do
    @user = User.find(session[:id])
    @tweet = Tweet.find(params[:id])
    if @user.tweets.include?(@tweet)
      @tweet.delete
      redirect to '/tweets'
    else
      redirect to '/tweets'
    end
  end

end
