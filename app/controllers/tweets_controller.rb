class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do # Loads form to Create new Tweet
    if logged_in?
      erb :'tweets/new'
    else
      redirect "/login"
    end
  end

  get '/tweets/:id' do # Displays single tweet
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect "/login"
    end
  end

  post '/tweets' do # Receives submitted form to create new Tweet
    if valid_tweet?
      @tweet = current_user.tweets.create(content: params[:content])
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/new"
    end
  end

  get '/tweets/:id/edit' do # Loads form to edit Tweet
    if logged_in?
      @tweet = Tweet.find_by(params[:id])
      erb :'tweets/edit_tweet'
    else
      redirect "/login"
    end
  end

  patch '/tweets/:id' do # Recives submitted form to edit Tweet
    if valid_tweet?
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.content = params[:content]
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{params[:id]}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find_by(params[:id])
      @tweet.delete
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

end
