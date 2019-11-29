class TweetsController < ApplicationController

# CREATE TWEET
  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    @tweet = Tweet.create(:content => params[:content])
    @tweet.user = current_user
    if @tweet.save
      @user = current_user
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to '/tweets/new'
    end
  end

  # SHOW ALL TWEETS
  get '/tweets' do
    if logged_in?
      @all_tweets = Tweet.all
      @user = current_user
      erb :'/tweets/tweets'
    else
      redirect to '/login'
    end
  end

  # SHOW SPECIFIC TWEET
  get '/tweets/:id' do
    if logged_in?
      @tweet = find_tweet
      erb :'/tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  # EDIT TWEET
  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = find_tweet
      if belongs_to_user?(@tweet)
        erb :'tweets/edit_tweet'
      else
        redirect to "/tweets"
      end
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = find_tweet
    @tweet.update(:content => params[:content])
    if @tweet.save
      redirect to "/tweets/#{params[:id]}"
    else
      redirect to "/tweets/#{params[:id]}/edit"
    end
  end

  # DELETE TWEET
  delete '/tweets/:id/delete' do
    if logged_in?
      @tweet = find_tweet
      if belongs_to_user?(@tweet)
        @tweet.destroy
        redirect to '/tweets'
      else
        redirect to "/tweets"
      end
    else
      redirect to '/login'
    end
  end

end
