class TweetController < ApplicationController

  # Index Action
  get '/tweets' do
    if session[:id] 
      @user = User.find(session[:id])
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end
  
  # New Action
  get '/tweets/new' do
    if session[:id] 
      # @users = User.all
      erb :'/tweets/new'
    else
      redirect '/login'
    end
  end
  
  # Create Action
  post '/tweets' do
    content = params['content']
    if content.empty?
      session[:flash] = "Please enter some content for your tweet."
      redirect '/tweets/new'
    else 
      tweet = Tweet.create(content: content)
      tweet.user = User.find(session[:id])
      tweet.save
      redirect "tweets/#{tweet.id}"
    end
  end
  
  # Show Action
  get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/show_tweet'
  end
  
  # Edit Action
  get '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    @users = User.all
    erb :'/tweets/edit'
  end
  
  # Patch Action
  patch '/tweets/:id' do

    tweet = Tweet.find(params[:id])
    tweet.update(params['tweet'])
    tweet.user = User.create(name: params['user_name']) unless params['user_name'].empty?

    tweet.save
    redirect "tweets/#{tweet.id}"
  end
  
  # Delete Action
  delete '/tweets/:id' do
    tweet = Tweet.find(params[:id])
    tweet.delete
  end
  
end