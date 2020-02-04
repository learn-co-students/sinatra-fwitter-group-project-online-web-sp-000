class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = User.find(session[:user_id])
      erb :'/tweets/tweets'
    else
      redirect to "/login"
    end
  end

  get '/tweets/new' do
    erb :'/tweets/new'
  end

  post '/tweets' do
    @user = current_user
    @tweet = Tweet.new(content: params[:content])
    @tweet.user_id = @user.id
    @tweet.save
  end

  # get '/tweets/:id' do
  #   binding.pry
  #   @tweet = Tweet.find_by(id: params[:id])
  #   erb :'/tweets/show_tweet'
  # end


end
