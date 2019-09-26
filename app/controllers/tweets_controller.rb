class TweetsController < ApplicationController

  get '/tweets' do
    # binding.pry
    if logged_in?
      @tweet = Tweet.all
      @user = current_user
      erb :'tweets/index'
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
    @tweet = Tweet.new(content: params[:content], user_id: session[:user_id])
    if !params[:content].empty?
      current_user.tweets << @tweet
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      # @user = current_user
      erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end
  end

end
