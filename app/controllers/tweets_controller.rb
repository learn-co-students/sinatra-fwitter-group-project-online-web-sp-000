class TweetsController < ApplicationController

  get '/tweets' do
    if session[:user_id] == nil
      redirect '/login'
    else
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    end
  end

  get '/tweets/new' do
    if session[:user_id] == nil
      redirect '/login'
    else
      erb :'/tweets/new'
    end
  end

  post '/tweets' do
    if params[:content] == ""
      redirect '/tweets/new'
    else
      Tweet.create(content: params[:content], user_id: session[:user_id])
      redirect '/tweets'
    end
  end

  get '/tweets/:id' do
    if session[:user_id] == nil
      redirect '/login'
    else
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show'
    end
  end

  get '/tweets/:id/edit' do
    if session[:user_id] == nil
      redirect '/login'
    else
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/edit'
    end
  end

  patch '/tweets/:id' do #edit action
    if params[:content] == ""
      redirect "/tweets/#{params[:id]}/edit"
    else
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.content = params[:content]
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/:id' do #delete action
    @tweet = Tweet.find_by_id(params[:id])
    if @tweet.user_id != session[:user_id]
      redirect '/tweets'
    else
      @tweet.delete
      redirect '/tweets'
    end
  end
end
