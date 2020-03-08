class TweetsController < ApplicationController

  #index page
  get '/tweets' do
    if logged_in?
      #show tweets
      @all = Tweet.all
      flash[:message] = "Welcome, #{current_user.username}"
      erb :'tweets/index'
    else
      #ask to login
      redirect '/login'
    end
  end

  #create - loggedin - assigns tweet - redirect to failure
  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if params[:content].empty?
      redirect '/tweets/new'
    else
      @tweet = Tweet.create(content: params[:content])
      current_user.tweets << @tweet
      redirect "/tweets/#{@tweet.id}"
    end
  end

  #show - loggedin - redirects based on issue
  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show'
    else
      redirect '/login'
    end
  end

  #edit - loggedin - their tweet - redirects based on issue
  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/edit'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if params[:content].empty?
      flash[:message] = "Cannot have empty tweet"
      redirect "/tweets/#{@tweet.id}/edit"
    elsif logged_in?
      @tweet.content = params[:content]
      @tweet.save
    end
    redirect "/tweets/#{@tweet.id}"
  end

  #delete - loggedin - their tweet
  delete '/tweets/:id' do
    tweet = Tweet.find(params[:id])
    if logged_in? && current_user == tweet.user
      tweet.delete
      redirect '/tweets'
    else
      flash[:message] = "Can't delete other users tweets"
      redirect "/tweets/#{tweet.id}"
    end
  end

end
