class TweetsController < ApplicationController

  get '/tweets' do
    if Helpers.is_logged_in?(session)
      @user = User.find(session[:user_id])
      erb :'/tweets/index'
    else
      redirect '/login'
    end
  end
  
  get '/tweets/new' do
    if Helpers.is_logged_in?(session)
      erb :'/tweets/new'
    else
      redirect '/login'
    end
  end
  
  post '/tweets' do
    if params[:content] == ""
      redirect '/tweets/new'
    else
      @user = User.find(session[:user_id])
      @user.tweets << Tweet.create(content: params[:content])
      @user.save
      redirect '/tweets'
    end
  end
  
  get '/tweets/:id' do
    if Helpers.is_logged_in?(session)
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show'
    else
      redirect '/login'
    end
  end
  
  get '/tweets/:id/edit' do
    if Helpers.is_logged_in?(session)
      @tweet = Tweet.find(params[:id])
      if @tweet.user.id == session[:user_id]
        erb :'/tweets/edit'
      else
        redirect '/login'
      end
    else
      redirect '/login'
    end
  end
  
  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if params[:content] == ""
      redirect "/tweets/#{@tweet.id}/edit"
    else
      @tweet.update(content: params[:content])
      redirect "/tweets/#{@tweet.id}"
    end
  end
  
  delete '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if @tweet.user.id == session[:user_id]
      @tweet.destroy
      redirect '/tweets'
    else
      redirect "/tweets/#{@tweet.id}"
    end
  end
  
  
end
