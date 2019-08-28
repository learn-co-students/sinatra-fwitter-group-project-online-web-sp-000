class TweetsController < ApplicationController

  get '/tweets' do
    @tweets = Tweet.all
    if logged_in?
      erb :'/tweets/index'
    else
      redirect '/users/login'
    end
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
      @tweet.save
      redirect "/tweets"
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
      if authorized?(@tweet)
        erb :'/tweets/edit'
      else
        redirect "/users/#{current_user.id}"
      end
    else
      redirect '/users/login'
    end
  end

  patch '/tweets/:id' do
    set_tweet
    if logged_in?
      if @tweet.user == current_user && params[:content] != ""
        @tweet.update(content: params[:content])
        redirect "/tweets/#{@tweet.id}"
      else
        redirect "/users/#{current_user.id}"
      end
    else
      redirect '/login'
    end
  end

  delete '/tweets/:id' do
    set_tweet
    if authorized?(@tweet)
      @tweet.destroy
      redirect '/tweets'
    else
      redirect '/tweets'
    end
  end

  private
  def set_tweet
    @tweet = Tweet.find(params[:id])
  end
end
