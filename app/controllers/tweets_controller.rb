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

end
