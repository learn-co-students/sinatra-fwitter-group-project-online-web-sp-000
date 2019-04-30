class TweetsController < ApplicationController

  get '/tweets' do 
    if logged_in?
      @user = current_user
    @tweets = Tweet.all
    erb :'/tweets/tweets'
  else 
    redirect to "/login"
  end 
  end 
  
  get '/tweets/new' do 
    if logged_in?
    erb :'/tweets/new'
  else 
    redirect to "/login"
  end 
end 
  
  get '/tweets/:id' do 
    if logged_in?
    @tweet = Tweet.find_by_id(params[:id])
    erb :'/tweets/show_tweet'
  else 
    redirect to "/login"
  end
end 
  
  post '/tweets' do 
    if params[:content] != ""
    @tweet = Tweet.create(content: params[:content])
    @tweet.user = current_user 
    @tweet.save
    redirect to "/tweets/#{@tweet.id}"
  else 
    redirect to "/tweets/new"
  end
end 
  
  get '/tweets/:id/edit' do
    if logged_in?
    @tweet = Tweet.find_by_id(params[:id])
    erb :'/tweets/edit_tweet'
  else 
    redirect to "/login"
  end
end 
  
  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if params[:content] != ""
    @tweet.update(content: params[:content])
    redirect to "/tweets/#{@tweet.id}"
  else 
    redirect to "/tweets/#{@tweet.id}/edit"
  end
end 
  
  delete '/tweets/:id/delete' do 
    if logged_in?
    @tweet = Tweet.find_by_id(params[:id])
    @user = User.find_by_id(@tweet.user_id)
    if @user == current_user 
    @tweet.destroy
  end
    redirect to "/tweets"
  end 
  end
end
