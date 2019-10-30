require 'pry'
class TweetsController < ApplicationController

    get '/tweets' do 
        @tweets = Tweet.all 
      if logged_in?
        erb:'tweets/index' 
      else 
        redirect to "/login"
      end 
    end

    get '/tweets/new' do 
      if logged_in?
         erb:'/tweets/new'
      else 
        redirect to "/login"
      end 
    end 

    post '/tweets' do 
        if params[:content] != ""
            @tweet = Tweet.create(content: params[:content])
            current_user.tweets << @tweet
        else 
            redirect to "/tweets/new"
        end 
    end 

    get '/tweets/:id' do 
      @tweet = Tweet.find(params["id"])
      if logged_in?
        erb:"tweets/show"
      else
        redirect to "/login"
      end
    end 

    get '/tweets/:id/edit' do 
        if logged_in? 
          @tweet = Tweet.find_by(id: params[:id])
        
        else 
          redirect "/login"
        end 
        
        if @tweet.user == current_user && @tweet != nil 
            erb:"/tweets/edit"
          else 
            redirect to "/tweets"
        end  
    end 

    patch '/tweets/:id' do 
      @tweet = Tweet.find_by(id: params[:id])
      @tweet.content = params[:content]
      @tweet.save 
    end 
    

end
