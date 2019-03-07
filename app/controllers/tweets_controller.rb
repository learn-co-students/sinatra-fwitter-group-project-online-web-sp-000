require './config/environment'

class TweetsController < ApplicationController

  get '/tweets/new' do 
    logged_in? ? erb(:'/new') : redirect('/login')
  end
  
  post '/tweets' do 
    @user = current_user
    params[:content].empty? ? redirect('/tweets/new') : @user.tweets.build(params)
    @user.save
    
    redirect "/tweets/#{Tweet.last.id}"
  end 
  
  get '/tweets/:id' do 
    if logged_in?
      @user = current_user
      @tweet = Tweet.find(params[:id])
      erb :'/show'
    else 
      redirect '/login'
    end 
  end 
  
  get '/tweets/:id/edit' do 
    if logged_in?  
      @tweet = Tweet.find(params[:id])
      erb :'/edit'
    else 
      redirect '/login'
    end 
  end 
  
  patch '/tweets/:id' do 
    redirect '/login' if !logged_in?
    @tweet = Tweet.find(params[:id])
     if !params[:content].empty?
        @tweet.content = params[:content] 
        @tweet.save
     else 
        redirect "/tweets/#{@tweet.id}/edit"
     end
  end
  
  delete '/tweets/:id' do 
    if logged_in? 
      user = current_user
      tweet = Tweet.find(params[:id])
      user == tweet.user ? tweet.delete : redirect("/login")
      redirect "/users/#{user.slug}"
    else 
      redirect '/login'
    end
  end
end
