require 'pry'
class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :'tweets/index'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      @user = current_user
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if (params[:content] == "")
      redirect "/tweets/new"
    else
      @user = current_user
      tweet = Tweet.create(:content => params[:content], :user_id => @user.id)
      redirect '/tweets'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet=Tweet.find(params[:id])
      @user= current_user
      if @tweet.user == @user
        erb :'/tweets/edit'
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      @user = current_user
      erb :'tweets/show'
    else
      redirect '/login'
    end
  end

  delete '/tweets/:id' do
    if logged_in?
      tweet = Tweet.find(params[:id])
      if tweet.user == current_user
        tweet.destroy
        redirect '/tweets'
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    if (params[:content] == '')
      redirect "/tweets/#{params[:id]}/edit"
    else
      tweet=Tweet.find(params[:id])
      tweet.update(:content => params[:content])
      redirect "/tweets/#{tweet.id}"
    end
  end
end
