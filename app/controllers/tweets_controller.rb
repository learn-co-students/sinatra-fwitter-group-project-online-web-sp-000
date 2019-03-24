class TweetsController < ApplicationController

  get '/tweets' do
    @user = User.find_by(id: session[:user_id])
    if @user
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if session[:user_id]
      erb :'tweets/new'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    if params[:content].empty?
      redirect to '/tweets/new'
    end
    tweet = Tweet.create(content: params[:content], user_id: session[:user_id])
    redirect to "/tweets/#{tweet.id}"
  end

  get '/tweets/:id' do
    if session[:user_id]
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if !session[:user_id]
      redirect to "/login"
    end
    @tweet = Tweet.find_by(id: params[:id])
    if session[:user_id] != @tweet.user_id
      redirect to "/tweets"
    end
    erb :'tweets/edit_tweet'
  end

  patch '/tweets/:id' do
    if params[:content].empty?
      redirect to "/tweets/#{params[:id]}/edit"
    end
    tweet = Tweet.find_by(id: params[:id])
    tweet.update(content: params[:content])
    redirect to "/tweets/#{tweet.id}"
  end

  post '/tweets/:id/delete' do
    tweet = Tweet.find_by(id: params[:id])
    if session[:user_id] && session[:user_id] == tweet.user_id
      tweet.delete
    end
    redirect to "/tweets"
  end

end
