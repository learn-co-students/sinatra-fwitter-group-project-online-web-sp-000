class TweetsController < ApplicationController

    get '/tweets' do 
        @tweets = Tweet.all 
        if is_logged_in?
          erb :'/tweets/index'
        else 
          redirect to '/login'
        end 
    end 

    get '/tweets/new' do 
      if is_logged_in?
        erb :'/tweets/create'
      else 
        redirect to '/login'
      end 
    end 

    get '/tweets/:id' do 
      @tweet = Tweet.find_by_id(params[:id])
      if is_logged_in?
        erb :'/tweets/show'
      else 
        redirect to '/login'
      end 
    end 

    get '/tweets/:id/edit' do 
      @tweet = Tweet.find_by_id(params[:id])
      if is_logged_in? && @tweet.user == current_user
        erb :'/tweets/edit'
      else 
        redirect to '/login'
      end 
    end 

    post '/tweets' do 
      @tweet = current_user.tweets
      if is_logged_in?
        if params[:content] == ""
          redirect to '/tweets/new'
        else
          @tweet.create(params)
        end
      end 
    end 

end
