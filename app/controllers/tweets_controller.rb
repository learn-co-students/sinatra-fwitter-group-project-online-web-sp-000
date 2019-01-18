class TweetsController < ApplicationController

  get '/tweets' do
    if current_user
      @user = current_user
      @tweets = Tweet.all
      erb :'tweets'
    else
      redirect '/login'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    @tweets = @user.tweets
    erb :'show'
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if logged_in?
      user = current_user
      tweet = user.tweet.build(content: params[:content])
      if tweet.valid? && params[:content].present?
        tweet.save
        redirect "/tweets"
      else
        redirect '/tweets/new'
      end
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect 'login'
    end
  end

  post '/tweets/:id' do
    tweet = Tweet.find(params[:id])
    tweet.content = params[:content]
    if tweet.save
      redirect "/tweets/#{tweet.id}/edit"
    else
      redirect "/tweets"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if !(@tweet.user_id == session[:id])
        erb :'/tweets/edit_tweet'
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

  delete '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if @tweet.user == current_user
        @tweet.destroy
        redirect '/tweets'
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

end
