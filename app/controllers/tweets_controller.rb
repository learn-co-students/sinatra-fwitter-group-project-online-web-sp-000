require 'pry'
class TweetsController < ApplicationController

  # we want this in a separate controller but may have inheritence issues

  get '/tweets/new' do
    erb :'tweets/new'
  end

  # get '/tweets/signup' do
    
  # end

  get '/tweets' do
     
    # binding.pry
    # @user =  Helpers.current_user(session)
    # @user = @user.find(session[:user_id])   # finding the id for the current user
    # @user.tweets # all the tweets that belong to the user  
    # @tweets.each do |t|      

    if !(Helpers.is_logged_in?(session))
      redirect to '/login'
    end

    @tweets = Tweet.all
    
    erb :'tweets/index'
  end

  post '/tweets' do

      if params[:content].blank? 
        erb :'/tweets/error'
      else
        @tweets = Tweet.create(content: params[:content])       
        redirect to '/tweets'
      end
  end  

    # following route does not work successfully
    get '/tweets/:id' do
 
      if Helpers.is_logged_in?(session) 
        @tweet = Tweet.find_by_id(params[:id])
        erb :'tweets/show'
      else
        redirect to '/login'
      end

    end

    # edit a tweet - for specific user

    # get '/tweets/:id/edit' do
    #     @tweet = Tweet.find_by_id(params[:id])
    # end

end
