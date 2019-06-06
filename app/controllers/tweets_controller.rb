class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?(session)
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?(session)
      erb :'/tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    @user = current_user(session)
    if !params[:content].empty?
      @user.tweets << Tweet.create(params)
      redirect '/tweets'
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?(session)
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if current_user(session) == @tweet.user
      @tweet.destroy
      redirect '/tweets'
    else
      redirect '/tweets'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?(session)
      @tweet = Tweet.find(params[:id])
      if @tweet.user == current_user(session)
        erb :'/tweets/edit_tweet'
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if !logged_in?(session)
      redirect '/login'
    elsif params[:content].empty?
      redirect "/tweets/#{@tweet.id}/edit"
    elsif @tweet.user == current_user(session)
      @tweet.update(content: params[:content])
      redirect "/tweets/#{@tweet.id}"
    else
      redirect '/tweets'
    end
  end

end
