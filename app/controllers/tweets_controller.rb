class TweetsController < ApplicationController

  get '/tweets' do
    erb :'/tweets/index'
  end

  get '/tweets/new' do
    erb :'/tweets/new'
  end

  post '/tweets' do
    if !logged_in?
      redirect '/'
    end
    if params[:content] != ""
      @tweet = Tweet.create(content: params[:content], user_id: current_user.id)
      redirect "/tweets/#{@tweet.id}"
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    set_tweet
    erb :'/tweets/show'
  end

  get '/tweets/new' do
    erb :'tweets/new'
  end

  get '/tweets/:id/edit' do
    set_tweet
    if logged_in?
      if @tweet.user == current_user
        erb :'/tweets/edit'
      else
        redirect "/users/#{current_user.id}"
      end
    else
      redirect '/'
    end
  end

  patch '/tweets/:id' do
    set_tweet
    if logged_in?
      if @tweet.user == current_user
        @tweet.update(content: params[:content])
        redirect "/tweets/#{@tweets.id}"
      else
        redirect "/users/#{current_user.id}"
      end
    else
      redirect '/'
    end
  end

  post '/tweets/:id/delete' do

  end

  private
  def set_tweet
    @tweet = Tweet.find(params[:id])
  end
end
