class TweetsController < ApplicationController
  get '/tweets' do
    if session[:user_id]
      @tweets = Tweet.all
      erb :'tweets/index'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if session[:user_id]
      @error = ''
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if params[:content] != ''
      Tweet.create(content: params[:content], user_id: session[:user_id])
      redirect to '/tweets'
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if session[:user_id]
      @tweet = Tweet.find_by(params[:id])
      erb :'tweets/show'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by(params[:id])
    if session[:user_id] && @tweet.user_id == session[:user_id]
      erb :'tweets/edit'
    else
      redirect '/login'
    end
  end

  post '/tweets/:id' do
    @tweet = Tweet.find_by(id: params[:id])
    if session[:user_id] && @tweet.user_id == session[:user_id] && params[:content] != ''
      @tweet.content = params[:content]
      @tweet.save
      redirect '/tweets/' + params[:id]
    elsif params[:content] == ''
      redirect '/tweets/' + params[:id] + '/edit'
    else
      redirect '/login'
    end
  end

  delete '/tweets/:id' do

    @tweet = Tweet.find_by(id: params[:id])
    if @tweet.user_id == session[:user_id]
      @tweet.destroy
    end
    redirect to "/tweets"
  end

end
