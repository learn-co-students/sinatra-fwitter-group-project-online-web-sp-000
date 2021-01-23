class TweetsController < ApplicationController

    get '/tweets' do
        if is_logged_in?
          erb :'/tweets/index'
        else
          redirect '/login'
        end
    end

    get '/tweets/new' do
      if is_logged_in?
        erb :'/tweets/new'
      else
        redirect '/login'
      end
    end

    post '/tweets' do
      tweet = Tweet.create(content: params[:content], user_id: current_user.id)
      redirect "/tweets/#{tweet.id}"
    end

    get '/tweets/:id' do
      @tweet = Tweet.find_by(id: params[:id])
      if @tweet && is_logged_in?
        erb :'/tweets/show'
      else
        redirect '/tweets' 
      end
    end

    get '/tweets/:id/edit' do
      @tweet = Tweet.find_by(id: params[:id])
      if @tweet && is_logged_in? && @tweet.user_id == current_user.id
        erb :'/tweets/edit'
      else
        redirect '/tweets'
      end
    end

    patch '/tweets/:id' do
      Tweet.find(params[:id]).update(content: params[:content])
      redirect "/tweets/#{params[:id]}"
    end

    delete '/tweets/:id' do
      Tweet.destroy(params[:id])
      redirect '/tweets'
    end

    get '/users/:username' do
      @user = User.find_by(username: params[:username])
      if @user && is_logged_in?
        erb :'/tweets/user'
      else
        redirect '/tweets' 
      end

    end
end
