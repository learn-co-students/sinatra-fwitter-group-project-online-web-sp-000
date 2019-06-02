class TweetsController < ApplicationController

  get '/tweets' do
    
    if logged_in?
      @user = current_user
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end
  
  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end
  
  post '/tweets' do
    if params["content"] != ""
      user = current_user
      user.tweets << Tweet.create(content: params["content"])
      user.save
      redirect '/tweets'
    else
      redirect '/tweets/new'
    end
  end
  
  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end
  
  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if current_user.tweets.include?(@tweet)
          
        erb :'tweets/edit_tweet'
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end
  
  post '/tweets/:id' do
    if params[:content] != ""
      tweet = Tweet.find(params[:id])
      tweet.content = params[:content]
      tweet.save
      
      redirect "/tweets/#{params[:id]}"
    else
      redirect "/tweets/#{params[:id]}/edit"
    end
  end
  
  post '/tweets/:id/delete' do
    user = current_user
    tweet = Tweet.find(params[:id])
    if user.tweets.include?(tweet)
      user.tweets.destroy(Tweet.find(params[:id]))
      user.save
    end
    redirect '/tweets'
  end
end
