class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = User.find(session[:user_id])
      erb :'/tweets/tweets'
    else
      redirect to "/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/new'
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    @user = current_user
    if !params[:content].empty?
      @tweet = Tweet.new(content: params[:content])
      @tweet.user_id = @user.id
      @tweet.save
      redirect "/tweets"
    else
      redirect "/tweets/new"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect "/login"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect "/login"
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by(id: params[:id])
    if !params[:content].empty?
      @tweet.content = params[:content]
      @tweet.save

    else
      #binding.pry
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id' do
    #binding.pry
    @tweet = Tweet.find_by(id: params[:id])
    if current_user.id == @tweet.user_id
      @tweet.delete
    end
    redirect "/tweets"
  end

end
