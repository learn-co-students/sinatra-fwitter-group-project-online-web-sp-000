class TweetsController < ApplicationController

# Always check if logged in

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'/tweets/index'
    else
      redirect '/login'
    end
  end


  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/new'
    else
      redirect :'/login'
    end
  end


  post '/tweets' do
    if logged_in?
      if params[:content] == ""
        redirect '/tweets/new'
      else
        @tweet = Tweet.create( content: params[:content] )
        @tweet.user_id = current_user.id
        if @tweet.save
          redirect "/tweets/#{@tweet.id}"
        else
          redirect '/tweets/new'
        end
      end
    else
      redirect '/login'
    end
  end


  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/tweet_page'
    else
      redirect to '/login'
    end
  end


  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
        if @tweet && @tweet.user == current_user
          erb :'tweets/edit_tweet'
        else
          redirect to '/tweets'
        end
    else
      redirect to '/login'
    end
  end


  patch '/tweets/:id' do

  end


  delete '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    erb :'/tweets/tweet_page'
  end


  post '/tweets/:id/delete' do

    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet && @tweet.user == current_user
        @tweet.delete
      end

      redirect to '/tweets'
    else
      redirect to '/login'
    end

  end


end
