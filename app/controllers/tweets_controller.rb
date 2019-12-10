require 'pry'
class TweetsController < ApplicationController

   
  # we want this in a separate controller but may have inheritence issues

  get '/tweets/new' do
    erb :'tweets/new'
  end

  get '/tweets' do
    
    # binding.pry
    # @user =  Helpers.current_user(session)
    # @user = @user.find(session[:user_id])   # finding the id for the current user
    # @user.tweets # all the tweets that belong to the user  
    # @tweets.each do |t|      
    
    @tweets = Tweet.all
    
    erb :'tweets/index'
  end

  post '/tweets' do

      @tweets = Tweet.create(content: params[:content])
      
      redirect to '/tweets'
  end       
    # get '/tweets/:id' do
           
    #     if Helper.is_logged_in?(session) 
    #     end
    # end

end
