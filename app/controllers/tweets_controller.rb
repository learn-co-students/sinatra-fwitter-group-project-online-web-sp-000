require './config/environment'
require 'sinatra/base'
require 'rack-flash'
require 'pry'

class TweetsController < ApplicationController
   use Rack::Flash
    configure do
    
        enable :sessions
        set :session_secret, "secret"
    end

   get '/tweets' do
      if !Helpers.is_logged_in?(session)
         redirect to '/login'
      end
      @user = Helpers.current_user(session)
      @tweets = Tweet.all
         
      erb :'/tweets/tweets'
      
   
   end

   get '/tweets/new' do
      if !Helpers.is_logged_in?(session)
         redirect to '/login'
      end
      erb:'/tweets/new'
   end

   post '/tweets' do
      user = Helpers.current_user(session)
      if params[:content].empty?
         flash[:empty] = "Please add content for your tweet."
         redirect to '/tweets/new'
      end
      @tweet = Tweet.create(:content => params[:content], :user_id => user.id)
      @tweet.save
      redirect to '/tweets'
   end

   get '/tweets/:id' do
      if !Helpers.is_logged_in?(session)
         redirect to '/login'
      end
      @tweet = Tweet.find(params[:id])
      erb:'/tweets/show_tweet'
   end

   get 'tweets/:id/edit' do
      if !Helpers.is_logged_in?(session)
         redirect to '/login'
      end
      @tweet = Tweet.find_by(params[:id])
      if Helpers.current_user(session).id != @tweet.user_id
         flash[:message] = "You can only edit your tweets."
         redirect to '/tweets'
      end
      erb:'/tweets/edit_tweet'
   end

   patch '/tweets/:id' do
      tweet = Tweet.find(params[:id])
      if params["content"].empty?
         flash[:empty] = "Please add content"
         redirect to '/tweets/#{params[:id}/edit'
      end
      tweet.update(:content => params["content"])
      tweet.save
      redirect to "/tweets/#{tweet.id}"
   end

   post '/tweets/:id/delete' do
      if !Helpers.is_logged_in?(session)
         redirect to '/login'
      end
      @tweet = Tweet.find(params[:id])
      if Helpers.current_user(session).id != @tweet.user_id
         flash[:wrong] = "You can only delete your tweets"
         redirect to '/tweets'
      end
      @tweet.delete
      redirect to '/tweets'
   end


end
