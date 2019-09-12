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
    erb :'tweets/new'
  end

  post '/tweets' do
    @tweet = Tweet.create(content: params[:content], user_id: session[:user_id])
    current_user.tweets << @tweet
    # binding.pry
    redirect :"tweets/#{@tweet.id}"
  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by(id: params[:id])
    erb :'tweets/show_tweet'
  end

  get '/tweets/:id/edit' do
    erb :'tweets/edit_tweet'
  end

end
