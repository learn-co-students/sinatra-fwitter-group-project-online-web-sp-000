require 'pry'
class TweetsController < ApplicationController

  # we want this in a separate controller but may have inheritence issues

  get '/tweets/new' do
    erb :'tweets/new'
  end

  get '/tweets' do

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
    # if id does not match, redirect to error edit page

ß    get '/tweets/:id/edit' do
        @tweet = Tweet.find_by_id(params[:id])
    end

    patch '/tweets/:id' do
      
    end

    # if id does not match, redirect to deelete error page

    # delete '/tweets/:id' do
    
    #   @tweet = Tweet.find_by_id(params[:id])

    #   session[:user_id] = @user.id

    #   if @tweet.user_id == @user.id
    #     @tweet.delete
    #   else
    #     erb :'/tweets/error'
    #   end

    # end

end