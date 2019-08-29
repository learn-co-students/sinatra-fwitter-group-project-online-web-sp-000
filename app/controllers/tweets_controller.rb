class TweetsController < ApplicationController

    get '/tweets' do

      if !logged_in?
        redirect '/login'
      end

      @user = current_user
      @tweets = Tweet.all
      erb :'/tweets/index'

    end

    get '/tweets/new' do
      if logged_in?
        erb :'/tweets/new'
      else
        redirect '/login'
      end
    end

    get '/tweets/:id' do
      if logged_in?
        @tweet = Tweet.find(params[:id])
        erb :'/tweets/show'
      else
        redirect '/login'
      end
    end

    get '/tweets/:id/edit' do
      if logged_in?
        @tweet = Tweet.find(params[:id])
        erb :'/tweets/edit'
      else
        redirect '/login'
      end
    end

    post '/tweets' do
      @user = current_user
      if params[:content] != ""
        @user.tweets << Tweet.create(content: params[:content])
      else
        redirect '/tweets/new'
      end
      redirect '/tweets'
    end
    
    delete '/tweets/:id' do
      @tweet = Tweet.find(params[:id])
      if logged_in? && (@tweet.user.id == session[:user_id])
        @tweet.delete
      end
      redirect '/tweets'
    end

    patch '/tweets/:id' do
      @tweet = Tweet.find(params[:id])
      if params[:content] != ""
        @tweet.update(content: params[:content])
      else
        redirect "/tweets/#{@tweet.id}/edit"
      end
      redirect '/tweets'
    end

end
