class TweetsController < ApplicationController

  #Index

  get '/tweets' do
    @tweets = Tweet.all

    erb :'tweets/tweets'
  end

  #Create
  get '/tweets/new' do
    @tweet = Tweet.new

    erb :'tweets/new'
  end

  post '/tweets' do
    @tweet = Tweet.create(params)

    redirect to "/tweets/#{ @tweet.id}"
  end

  #Show
  get '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])

    erb :'tweets/show_tweet.erb'
  end

  #Edit
  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])

    erb :'tweets/edit_tweet'
  end

  #Update
  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.update(params[:tweet])

    redirect to "/tweets/#{ @tweet.id}"
  end

  #Delete
  delete '/tweets/:id' do
    Tweet.destroy(params[:id])

    redirect to '/tweets'
  end
end
