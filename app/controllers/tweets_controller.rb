class TweetsController < ApplicationController

  get '/tweets' do
    if Helpers.is_logged_in?(session)
      erb :'tweets/index'
    else
      redirect 'users/login'
    end
  end

  get '/tweets/new' do
    if Helpers.is_logged_in?(session)
      erb :'tweets/new'
    else
      redirect 'users/login'
    end
  end

  post '/tweets' do

    if Helpers.is_logged_in?(session)
      if params["content"] == ""
        redirect 'tweets/new'
      else
        @tweet = Tweet.create(content: params["content"], user_id: session[:user_id])
        erb :'tweets/index'
      end
    end
  end

  get '/tweets/:id' do
    if Helpers.is_logged_in?(session)
      @tweet = Tweet.find_by(id: params[:id])
      erb :'tweets/show'
    else
      redirect 'users/login'
    end
  end

  get '/tweets/:id/edit' do
    if Helpers.is_logged_in?(session)
      @tweet = Tweet.find_by(id: params[:id])
      @user = User.find_by(id: @tweet.user_id)
      if @user.id == session[:user_id] && @tweet.content != ""
        erb :"tweets/edit"
      end
    else
      redirect 'users/login'
    end
  end

  patch '/tweets/:id' do

    if Helpers.is_logged_in?(session)
      @tweet = Tweet.find_by(id: params[:id])
      @user = User.find_by(id: @tweet.user_id)
      if @user.id == session[:user_id] && @tweet.content != ""
        @tweet.update(content: params["tweet"]["content"])
        redirect "tweets/#{@tweet.id}/edit"
      end
    end
  end

  delete '/tweets/:id' do
    if Helpers.is_logged_in?(session)
      @tweet = Tweet.find_by(id: params[:id])
      @user = User.find_by(id: @tweet.user_id)
      if @user.id == session[:user_id]
        @tweet.delete
        redirect "/tweets"
      end
    else
      redirect '/login'
    end

  end


end
