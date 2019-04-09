class TweetsController < ApplicationController
  get '/tweets' do
    if logged_in?
      @user = current_user
      erb :'/tweets/tweets'
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
    if params[:content].empty?
      redirect '/tweets/new'
    else
      @tweet = Tweet.create(:content => params[:content])
      @tweet.user_id = current_user.id
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if @tweet && users_tweet?
        erb :'/tweets/edit_tweet'
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    if params[:content].empty?
      redirect "/tweets/#{params[:id]}/edit"
    else
      if logged_in? && users_tweet?
        @tweet.update(:content => params[:content])
        @tweet.save
        redirect "/tweets/#{@tweet.id}"
      else
        redirect '/login'
      end
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if logged_in? && users_tweet?
      @tweet.delete
      redirect "/tweets"
    else
      redirect '/login'
    end
  end

  def users_tweet?
    current_user.id == @tweet.user_id
  end
end
