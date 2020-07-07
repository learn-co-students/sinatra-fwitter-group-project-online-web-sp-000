require 'pry'
class TweetsController < ApplicationController
    enable :sessions
    set :session_secret, 'fwitter'
    set :public_folder, 'public'
    set :views, 'app/views'

  # #Shows Tweets index page for user's tweets
  # get '/tweets' do
  #   @tweet = Tweet.all
  #   if logged_in?
  #     @user = current_user
  #     erb :'tweets/tweets'
  #   else
  #     redirect to('/login')
  #   end
  # end

    #Shows Tweets index page for ALL tweets
    get '/tweets' do
      @user = current_user
      if logged_in?
        erb :'tweets/all'
      else
        redirect to('/login')
      end
    end


  #Shows the New Tweet form and makes a new tweet
  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect to('/login')
    end
  end

  post '/tweets' do 
    @user = current_user
    @tweet = Tweet.create(content: params[:content], user: @user)
    if @tweet.save
      redirect to("/tweets/#{@tweet.id}")
    else
      redirect to('/tweets/new')
    end
  end

  #Shows an individual tweet
  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      erb :'tweets/show'
    else
     redirect to('/login')
    end
  end

  #edits an individual tweet
  patch '/tweets/:id/edit' do
    @tweet = Tweet.find_by(id: params[:id])
    @user = current_user
    if @tweet.update(content: params[:content], user: @user)
      redirect to("tweets/#{@tweet.id}")
    else
      redirect to("/tweets/#{@tweet.id}/edit")
    end
  end
  
  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by(id: params[:id])
    if logged_in? && @tweet.user == current_user
      erb :'tweets/edit'
    else
      redirect to('/login')
    end
  end

  

  #deletes an individual tweet
  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by(id: params[:id]) #current_user.tweets.find_by(:id => params[:id])
    #binding.pry
    if current_user.id == @tweet.user_id
      if @tweet && @tweet.destroy
        redirect to('/tweets')
      else
        redirect "/tweets/#{@tweet.id}"
      end
    else
      redirect "/tweets"
    end
  end
end
