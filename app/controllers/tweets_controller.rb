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
    @tweet = Tweet.create(content: params[:content], user_id: session[:user_id])
    current_user.tweets << @tweet
    redirect :"tweets/#{@tweet.id}"
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
      if @tweet.belongs_to current_user
        erb :'tweets/edit_tweet'
      else
        redirect to :"/tweets"
      end
    else
      redirect to :"/login"
    end
  end

end
