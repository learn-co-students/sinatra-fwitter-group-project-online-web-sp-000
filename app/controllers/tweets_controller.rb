class TweetsController < ApplicationController

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  get '/tweets' do
    if !logged_in?
      redirect '/login'
    end
    @user = current_user
    @tweets = Tweet.all
    erb :'tweets/tweets'
  end

  post '/tweets' do
    if params[:content].empty?
      redirect "/tweets/new"
    end
    tweet = Tweet.create(params)
    tweet.user = current_user
    tweet.save
    redirect "/tweets/#{tweet.id}"
  end

  get '/tweets/:id' do
    if !logged_in?
      redirect "/login"
    end
    @tweet = Tweet.find(params[:id])
    erb :'tweets/show'
  end

  get '/tweets/:id/edit' do
    if !logged_in?
      redirect "/login"
    end
    @tweet = Tweet.find(params[:id])
    erb :'tweets/edit'
  end

  patch '/tweets/:id' do
    if params[:content].empty?
      redirect "/tweets/#{params[:id]}/edit"
    end
    tweet = Tweet.find(params[:id])
    tweet.update(content: params[:content])
    redirect "/tweets/#{tweet.id}"
  end

  delete '/tweets/:id' do
    tweet = Tweet.find(params[:id])
    if current_user.id != tweet.id
      redirect '/tweets'
    end
    tweet.destroy
  end

end