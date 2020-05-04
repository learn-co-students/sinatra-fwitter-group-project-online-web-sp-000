class TweetsController < ApplicationController

  get '/tweets' do
    if is_logged_in?(session)
      @all_tweets = Tweet.all
      @all_users = User.all

      erb :'tweets/index'
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    erb :'tweets/new'
  end

  post '/tweets' do
    @tweet = Tweet.new(content: params[:content])
    @tweet.user = current_user
    @tweet.save
    
    redirect '/tweets'
  end

  helpers do

    def is_logged_in?(session)
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

  end

end
