require 'pry'
class TweetsController < ApplicationController

  get '/tweets' do
    @tweets = Tweet.all
    @user = current_user
    if logged_in?
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
    erb :'/tweets/new'
    else
    redirect '/login'
    end
  end

  post '/tweets' do
    if !logged_in?
      redirect '/index'
    end
    if params[:content] != ""
      @tweet = Tweet.create(content: params[:content], user_id: current_user.id)
      @tweet.save
      redirect '/tweets'
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    set_tweet
    if logged_in?
      erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/new'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    set_tweet
    if logged_in?
      if authorized?(@tweet)
        erb :'/tweets/edit_tweet'
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

  post '/tweets/:id' do
    set_tweet
    if logged_in?
      if params[:content] != ""
        @tweet.update(content: params[:content])
        redirect "/tweets/#{@tweet.id}"
      else
        redirect "/tweets/#{@tweet.id}/edit"
      end
    else
      redirect '/login'
    end
  end

  post '/tweets/:id/delete' do
    set_tweet
    if logged_in? && authorized?(@tweet)
      @tweet.destroy
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  private
  def set_tweet
    @tweet = Tweet.find_by(params[:id])
  end
end
