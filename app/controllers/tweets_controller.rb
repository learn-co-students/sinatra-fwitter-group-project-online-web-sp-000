class TweetsController < ApplicationController

  get '/tweets' do

    if Helpers.is_logged_in?(session)
      @user = User.find(session[:user_id])
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if Helpers.is_logged_in?(session)
      @user = User.find(session[:user_id])
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if params[:content].empty?
      redirect '/tweets/new'
    else
      Tweet.create(content: params[:content], user_id: session[:user_id])
      redirect '/tweets'
    end
  end

  get '/tweets/:id' do
    if Helpers.is_logged_in?(session)
      @user = User.find(session[:user_id])
      @tweet = Tweet.find(params[:id].to_i)
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  delete '/tweets/:id' do
    if Helpers.is_logged_in?(session)
      @tweet = Tweet.find(params[:id])
      if @tweet.user_id == session[:user_id]
        @tweet.destroy
        redirect '/tweets'
      else
        redirect "tweets/#{@tweet.id}"
      end  
    else
      redirect '/login'
    end

  end

  get '/tweets/:id/edit' do
    if Helpers.is_logged_in?(session)
      @user = User.find(session[:user_id])
      @tweet = Tweet.find(params[:id].to_i)
      erb :'tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    if Helpers.is_logged_in?(session)
      if params[:content].empty?
        redirect "tweets/#{params[:id]}/edit"
      else
        @user = User.find(session[:user_id])
        @tweet = Tweet.find(params[:id].to_i)
        @tweet.update(content: params[:content])
        redirect "tweets/#{@tweet.id}"
      end
    else
      redirect '/login'
    end
  end

end
