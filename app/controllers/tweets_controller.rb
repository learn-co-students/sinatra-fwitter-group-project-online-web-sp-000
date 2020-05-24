class TweetsController < ApplicationController
    get '/tweets' do
      return erb :'tweets/all_tweets' if logged_in?
      
      redirect to '/login'
    end
  
    get '/tweets/new' do  
      erb :'tweets/new_tweet' if logged_in?
      redirect to '/login'
    end
  
    post '/tweets' do
      if !logged_in?
        redirect to '/login'
      end
      if params[:content] == ""
        redirect to "/tweets/new"
      end
      @tweet = current_user.tweets.build(content: params[:content])
      if @tweet.save
        redirect to "/tweets/#{@tweet.id}"
      else
        redirect to "/tweets/new"
      end
    end
  
    get '/tweets/:id' do
      if !logged_in?
        redirect to '/login'
      end
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show'
    end
  
    get '/tweets/:id/edit' do
      if !logged_in?
        redirect to '/login'
      end
      @tweet = Tweet.find_by_id(params[:id])
      return erb :'tweets/edit' if @tweet&.user == current_user
      redirect to '/tweets'
    end
  
    patch '/tweets/:id' do
      if !logged_in?
        redirect to '/login'
      end
      if params[:content] == ""
        redirect to "/tweets/#{params[:id]}/edit"
      end
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet&.user == current_user
        redirect to '/tweets'
      end
      if @tweet.update(content: params[:content])
        redirect to "/tweets/#{@tweet.id}"
      else
        redirect to "/tweets/#{@tweet.id}/edit"
      end
    end
  
    delete '/tweets/:id/delete' do
      if !logged_in?
        redirect to '/login'
      end
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.destroy if @tweet&.user == current_user
      redirect to '/tweets'
    end
  end