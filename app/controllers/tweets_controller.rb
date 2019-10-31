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
          if @tweet.user == current_user && @tweet != nil 
              erb:"/tweets/edit"
            else 
              redirect to "/tweets"
        end 
        else 
          redirect "/login"
        end  
    end 

    patch '/tweets/:id' do
      if logged_in?
        if params[:content] == ""
          redirect to "/tweets/#{params[:id]}/edit"
        else 
          @tweet = Tweet.find_by(id: params[:id])
          if @tweet.user == current_user
            @tweet.content = params[:content]
            @tweet.save 
            redirect to "/tweets/#{@tweet.id}"
          else 
            redirect to "/tweets"
          end
        end 
      else 
        redirect to "/login"
      end 
      
    end 

    delete '/tweets/:id/delete' do 
      @tweet = Tweet.find_by(id: params[:id])
      if logged_in? && current_user == @tweet.user 
        @tweet.delete 
      end 
    end 

end
