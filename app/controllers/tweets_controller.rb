class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
    erb :'/tweets/tweets'
   end
  end

  get '/tweets/new' do

    erb :"/tweets/new"
  end

  post '/tweets' do
    if logged_in? && current_user
      @tweet = Tweet.new(content: params[:content])
      @tweet.user_id = current_user.id
      @tweet.save
    end
    redirect '/tweets/show'
  end



end
