class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
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
    @tweet = Tweet.new(content: params[:content], user_id: session[:user_id])

    if @tweet.save
      current_user.tweets << @tweet
      redirect :"tweets/#{@tweet.id}"
    else
      redirect :"/tweets/new"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      erb :'tweets/show_tweet'
    else
      redirect to :"/login"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])

      if @tweet.user == current_user
        erb :'tweets/edit_tweet'
      else
        redirect to :"/tweets"
      end
    else
      redirect to :"/login"
    end
  end

  patch '/tweets/:id/edit' do

    @tweet = Tweet.find_by(id: params[:id])

    if @tweet.user == current_user && !params[:content].empty?
      @tweet.update(content: params[:content])
      redirect to :"/tweets/#{@tweet.id}"
    elsif logged_in? && params[:content].empty?
      redirect to :"/tweets/#{@tweet.id}/edit"
    else
      redirect to :"/login"
    end
  end

  delete '/tweets/:id/delete' do

    @tweet = Tweet.find_by(id: params[:id])

    if @tweet.user == current_user
        @tweet.delete
    elsif logged_in?
      redirect to :"/tweets"
    else
    redirect to :"/login"
    end
  end

end
