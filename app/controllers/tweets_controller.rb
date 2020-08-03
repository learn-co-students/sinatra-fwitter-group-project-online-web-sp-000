class TweetsController < ApplicationController

    get '/tweets' do 
        @tweets = Tweet.all 
        if is_logged_in?
          erb :'/tweets/index'
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
      if is_logged_in? 
        @tweet = Tweet.find_by_id(params[:id])
        if @tweet && @tweet.user == current_user
          erb :'/tweets/edit'
        end 
      else 
        redirect to '/login'
      end 
    end 

    patch '/tweets/:id' do
      if is_logged_in?
        if params[:content] == ""
          redirect to "/tweets/#{params[:id]}/edit"
          binding.pry
        else
          @tweet = Tweet.find_by_id(params[:id]) 
          if @tweet && @tweet.user == current_user
            if @tweet.update(:content => params[:content])
              redirect to "/tweets/#{@tweet.id}"
            else
              redirect to "/tweets/#{@tweet.id}/edit"
            end
          else
            redirect to '/tweets'
          end
        end
      else
        redirect to '/login'
      end
    end

    delete '/tweets/:id/delete' do 
      if is_logged_in?
        @tweet = Tweet.find_by_id(params[:id])
        if @tweet && @tweet.user == current_user
          @tweet.delete
        end 
      end 
    end 
 
end
