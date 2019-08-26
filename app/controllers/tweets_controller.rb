class TweetsController < ApplicationController

  get '/tweets' do
    erb :'/tweets/index'
  end

  get '/tweets/new' do
    erb :'/tweets/new'
  end

  post '/tweets' do
    if !logged_in?
      redirect '/'
    end
    if params[:content] != ""
      @tweet = Tweet.create(content: params[:content], user_id: current_user.id)
      redirect "/tweets/#{@tweet.id}"
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/show'
  end

  get '/tweets/:id/edit' do
    erb :"/tweets/#{@tweet.id}"
  end

  patch '/tweets/:id' do

  end

  post '/tweets/:id/delete' do

  end
end
