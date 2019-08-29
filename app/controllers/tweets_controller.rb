class TweetsController < ApplicationController

  #tweets index page
  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect to '/login'
    end
  end

  #creates new tweet
  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect to '/login'
    end
  end

  #if logged in, and the tweet is empty, go to create new tweet
  # else allow user to create and save tweet with tweet slug and redirect to new tweet w/slug
  # else go back to create new tweet
  post '/tweets/new' do
    if logged_in?
     if params[:content] == ""
      redirect to '/tweets/new'
    else
      @tweet = current_user.tweets.build(content: params[:content])
      if @tweet.save
        redirect to "/tweets/#{@tweet.id}"
      else
        redirect to '/tweets/new'
      end
    end
  else
    redirect to '/login'
  end
  end

  #displays info for a single tweet
  get '/tweets/:id' do
    if logged_in?
      @tweet =Tweet.find(params[:id])
      erb :'tweets/show'
    else
      redirect to '/login'
    end
  end

end
