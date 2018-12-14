class TweetsController < ApplicationController
  get '/tweets' do
    if logged_in?
      erb :'/tweets/index'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if !params[:content].empty?
      tweet = Tweet.create(user: current_user, content: params[:content])

      redirect "/tweets/#{tweet.id}"
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])

      erb :'/tweets/show'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])

      erb :'/tweets/edit'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    tweet = Tweet.find(params[:id])

    if params[:content].empty?
      redirect "/tweets/#{tweet.id}/edit"
    elsif logged_in? && current_user == tweet.user
      tweet.update(content: params[:content])
      redirect "/tweets/#{tweet.id}"
    else
      redirect '/login'
    end
  end

  delete '/tweets/:id/delete' do
    tweet = Tweet.find(params[:id])

    if logged_in? && current_user == tweet.user
      tweet.delete
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

end
