require 'pry'
class TweetsController < ApplicationController

  get '/tweets' do
    if is_logged_in?
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect '/users/login'
    end
  end
  
  get '/tweets/new' do
    if is_logged_in?
      @user = current_user
      erb :'/tweets/new'
    else
      redirect '/login'
    end
  end
  
  post '/tweets' do
    if is_logged_in?
      if params[:content].empty?
        redirect '/tweets/new'
      else
        @tweet = Tweet.new(:content => params[:content], :user_id => session[:user_id])
        @tweet.save
      end
    else
      redirect '/login'
    end
  end
  
  get '/tweets/:id' do
    if is_logged_in?
      @tweet = Tweet.find_by(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end
  end
  
  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    if is_logged_in? && @tweet.user_id == current_user.id
      erb :'/tweets/edit_tweet'
    else
      redirect '/login'
    end
  end
  
  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
     if !params[:content].empty?
      @tweet.update(:content => params[:content])
      @tweet.save
      redirect "/tweets/#{params[:id]}"
    else
      redirect "/tweets/#{params[:id]}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    if is_logged_in?
      if @tweet.user_id == current_user.id
        @tweet.delete
        redirect '/tweets'
      else
        redirect '/tweets'
      end
    else
      redirect "/login"
    end
  end
  
  def is_logged_in?
    !!session[:user_id]
  end

  def current_user
    User.find(session[:user_id])
  end

end

