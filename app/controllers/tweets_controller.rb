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
      if logged_in?
         erb :'./tweets/new'
      else 
         redirect to "/login"
      end 
   end

   post '/tweets' do 
      #binding.pry
      @user = User.find_by(params[:user_id])
      @tweets = Tweet.all
      
      if params[:content] == " " || params[:content] == ""
         redirect to "/tweets/new"
      else 
         @tweet = Tweet.new
         @tweet.content = params[:content]
         @tweet.user_id = @user.id 
         @tweet.save 
         erb :'./tweets/show_tweet'
      end 
   end 
  
end
