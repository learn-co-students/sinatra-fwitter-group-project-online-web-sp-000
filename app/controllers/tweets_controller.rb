class TweetsController < ApplicationController

  get '/tweets' do
    @tweets = Tweet.all
    erb :"/tweets/tweets"
  end

  get '/tweets/new' do
    if logged_in?
      erb :"/tweets/new"
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if !params[:content].empty?
      @tweet = current_user.tweets.create(content: params[:content])

      redirect '/tweets/#{tweet.id}'
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweets = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(paramas[:id])
      @tweet.user_id = current_user.id

      erb :'tweets/edit_tweet'
    else
    redirect '/login'
    end
  end

  patch '/tweets/:id' do
    if !params[:content].empty?
      @tweet = Tweet.find(params[:content])
      @tweet.content = params[:content]
      @tweet.save

      redirect '/tweets'
    else
      redirect '/tweets/#@tweet.id'

    end
  end

  delete '/tweets/:id/delete' do

    @tweet = Tweet.find(params[:content])
    if current_user.id == @tweet.user_id
      @tweet.delete
      redirect 'tweets'
    else
      redirect '/tweet/#{@tweet.id}'
    end
  end


end
