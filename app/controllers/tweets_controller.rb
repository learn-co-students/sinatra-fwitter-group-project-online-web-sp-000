class TweetsController < ApplicationController
  get '/tweets' do
    if logged_in?
      @user = User.find(session[:user_id])
      erb :'tweets/index'
    else
      redirect "/login"
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
    if logged_in? && params[:content] != ""
      @tweet = Tweet.create(content: params[:content], user_id: session[:user_id])
      erb :'tweets/show'
    elsif logged_in? && params[:content] == ""
      redirect '/tweets/new'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if !logged_in?
      redirect '/login'
    elsif logged_in?
      @tweet = Tweet.find(params[:id])
      if session[:user_id] == @tweet.user.id
        erb :'tweets/edit'
      else
        redirect '/tweets'
      end
    end
  end

  patch '/tweets/:id' do
    if !logged_in?
      redirect '/login'
    elsif logged_in? && (params[:content] != "")
      @tweet = Tweet.find(params[:id])
      @tweet.content = params[:content]
      @tweet.save
      erb :'tweets/show'
    else
      redirect "/tweets/#{params[:id]}/edit"
    end
  end

  delete '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if !logged_in?
      redirect '/login'
    elsif logged_in? && (session[:user_id] == @tweet.user.id)
      @tweet.delete
      redirect '/tweets'
    else
      redirect '/tweets'
    end
  end

end
