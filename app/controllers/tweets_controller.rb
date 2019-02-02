class TweetsController < ApplicationController

  #load tweet create form
  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else 
      redirect to '/login'
    end
  end

  #tweets index page
  get '/tweets' do 
    if logged_in?
      @user = current_user
      erb :'tweets/tweets'
    else 
      redirect to '/login'
    end
  end

  #create new tweet
  post '/tweets' do 
    if logged_in?
      if params["content"] != ""
        tweet = Tweet.create(content: params["content"])
        tweet.user_id = session[:user_id]
        tweet.save
        redirect to '/tweets'
      else
        redirect to '/tweets/new'
      end
    else
      redirect :'/login'
    end
  end

  #show one tweet
  get '/tweets/:id' do 
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  #load edit form
  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/edit_tweet'
    else
      redirect to '/login'
    end
  end 

  #edit one tweet
  patch '/tweets/:id' do 
    if logged_in?
      if params["content"] != ""
        @tweet = Tweet.find(params[:id])
        @tweet.update(content: params["content"])
        erb :'tweets/show_tweet'
      else
        redirect to "/tweets/#{params[:id]}/edit"
      end
    else
      redirect to '/login'
    end
  end

  #delete one tweet
  delete '/tweets/:id/delete' do
    if logged_in?
      tweet = Tweet.find(params[:id])
      if tweet.user_id == session[:user_id]
        Tweet.destroy(params[:id])
      end
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end

end