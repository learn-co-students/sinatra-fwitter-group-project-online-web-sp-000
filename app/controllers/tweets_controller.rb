class TweetsController < ApplicationController

   get '/tweets' do
      
      if logged_in?
         # @user = current_user
         erb :'/tweets/index'
      else
         redirect "/login"
      end
   end

   get '/tweets/new' do
      if logged_in?
         erb :'tweets/new'
      else
         redirect "/login"
      end
   end

   post '/tweets' do
      if logged_in? && !params[:content].empty?
         current_user.tweets << Tweet.create(content: params[:content])
         current_user.save
      else
         redirect "/tweets/new"
      end
   end

   get '/tweets/:id' do
      if logged_in?
         @tweet = Tweet.find(params[:id])
         erb :'tweets/show'
      else
         redirect "/login"
      end
   end

   delete '/tweets/:id' do
      if current_user == Tweet.find(params[:id]).user
         Tweet.destroy(params[:id])
      else
      end
   end

   get '/tweets/:id/edit' do
      if !logged_in?
         redirect "/login"
      else
         @tweet = Tweet.find(params[:id])

         if logged_in? && @tweet.user == current_user
            erb :'/tweets/edit'
         else
            redirect "/login"
         end
      end
   end

   patch '/tweets/:id' do
      @tweet = Tweet.find(params[:id])
      if !params[:content].empty?
         @tweet.content = params[:content]
         @tweet.save

         redirect "/tweets/#{@tweet.id}"
      else
         redirect "/tweets/#{@tweet.id}/edit"
      end
   end
end
