class TweetsController < ApplicationController

   get '/tweets' do 
      @tweets = Tweet.all 
      @user = User.find_by(params[:id])

      if !logged_in?
         redirect to "/login"
      else 
         erb :'./tweets/tweets'
      end 
   end 

   get '/tweets/new' do 
      @tweets = Tweet.all
      erb :'./tweets/new'
   end

   post '/tweets' do 
      #binding.pry
      @tweets = Tweet.all
      @tweet = Tweet.new
      @tweet.content = params[:content]
      @tweet.save 

      erb :'./tweets/show_tweet'
   end 
  
end
