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

   post '/tweets' do 
   end 
end
