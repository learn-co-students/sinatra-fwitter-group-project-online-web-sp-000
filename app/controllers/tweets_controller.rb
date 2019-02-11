require 'pry'
class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      @user = current_user
      erb :'/tweets/tweets'
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/new'
    else
      redirect "/login"
    end
  end

  post '/tweets' do
      if params[:content] != ""
        @tweet = Tweet.create(content: params[:content], user_id:session[:user_id])
        @tweet.save
        redirect "/tweets"
      else
        redirect "/tweets/new"
      end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect "/login"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if current_user.id == @tweet.user_id
        erb :'tweets/edit_tweet'
      else
        redirect "/tweets"
      end
    else
      redirect "/login"
    end
  end

  patch '/tweets/:id' do

    if logged_in? && params[:content] != ""
      @tweet = Tweet.find(params[:id])
        if current_user.id == @tweet.user_id
          @tweet.content = params[:content]
          @tweet.save
          redirect "/tweets/#{@tweet.id}"
        else
          redirect "/tweets"
        end
    elsif logged_in? && params[:content] == ""
      @tweet = Tweet.find(params[:id])
      redirect "/tweets/#{@tweet.id}/edit"
    else
      redirect "/login"
    end
  end

  delete '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if logged_in? && current_user.id == @tweet.user_id
      @tweet.delete
      redirect "/tweets"
    else
      redirect "/login"
    end
  end
end
