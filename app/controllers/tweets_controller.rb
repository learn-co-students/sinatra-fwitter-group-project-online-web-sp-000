class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in? && current_user
      @tweets = Tweet.all
    erb :'/tweets/tweets'
   end
  end

  get '/tweets/new' do
    if logged_in?
      erb :"/tweets/new"
    end
  end

  post '/tweets' do
    if logged_in? && params[:content] != ""
      @tweet = Tweet.new(content: params[:content])
      @tweet.user_id = current_user.id
      @tweet.save
    end
    redirect '/tweets/show'
  end



end
