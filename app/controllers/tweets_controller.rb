class TweetsController < ApplicationController
  
  get '/tweets' do
    redirect "/login" if !Helper.is_logged_in?(session)
    
    @user = User.find(session[:user_id])
    erb :"/tweets/tweets"
  end
  
  get '/tweets/new' do
    redirect "/login" if !Helper.is_logged_in?(session)
    
    erb :'/tweets/new'
  end
  
  post '/tweets' do
    redirect "/tweets/new" if params[:content].empty?
    
    tweet = Tweet.create(content: params[:content], user_id: session[:user_id])
    redirect "/tweets"
  end
  
  get '/tweets/:id' do
    redirect "/login" if !Helper.is_logged_in?(session)
    
    @tweet = Tweet.find(params[:id])
    erb :"/tweets/show_tweet"
  end
  
  post '/tweets/:id' do
    redirect "/tweets/#{params[:id]}/edit" if params[:content].empty?
    
    Tweet.update(params[:id], content: params[:content])
    redirect "/tweets/#{params[:id]}"
  end
  
  get '/tweets/:id/edit' do
    redirect "/login" if !Helper.is_logged_in?(session)
    
    @tweet = Tweet.find(params[:id])
    erb :"/tweets/edit_tweet"
  end
  
  post '/tweets/:id/delete' do
    tweet = Tweet.find(params[:id])
    redirect "/tweets/#{params[:id]}" if tweet.user_id != session[:user_id]
    
    tweet.delete
    redirect "/tweets"
  end
  
end
