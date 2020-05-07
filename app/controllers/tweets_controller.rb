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
      @user = current_user
      erb :'/tweets/new' 
    else
      redirect '/login'
    end
  end
  
  post '/tweets' do

    if params[:content] == ""
      redirect '/tweets/new'
    end 
    @user = current_user
    @tweet = Tweet.new(content: params["content"], user_id: @user.id)
    if @tweet.valid?
      @tweet.save
      redirect '/tweets'
    else
      redirect '/tweets/new'
    end
  end
  
  get '/tweets/:id' do 
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end 
    
    #@tweet = Tweet.find(params[:id])
    #if @tweet.user == current_user
      #erb :'/tweets/edit_tweet'
    #else
      #redirect '/login'
    #end
    
  end
  
  get '/tweets/:id/edit' do
    redirect '/login' if !logged_in?

    @tweet = Tweet.find(params[:id])
    if @tweet.user == current_user
      erb :'/tweets/edit_tweet'
    else
      redirect '/login'
    end

  end
  
  patch '/tweets/:id' do 
    @tweet = Tweet.find(params[:id])

    if params[:content].empty?
      redirect "/tweets/#{@tweet.id}/edit"
    end

    @tweet.update(content: params[:content])
    @tweet.save
    redirect "/tweets/#{@tweet.id}"
    
  end
  
  delete '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if @tweet.user == current_user
        @tweet = Tweet.find_by_id(params[:id])
        @tweet.delete
        redirect '/tweets'
      else 
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

end