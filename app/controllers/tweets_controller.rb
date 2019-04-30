class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = current_user
      erb :'/tweets/index'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/new'
    else
      redirect 'login'
    end
  end

  post '/tweets' do
    if params[:content] != ""
      tweet = Tweet.create(content:params[:content], user: current_user)
      redirect "/users/#{current_user.slug}"
    else
      redirect '/tweets/new'
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
    @tweet = Tweet.find(params[:id])
binding.pry
    if logged_in? && current_user.id == @tweet.user_id
      erb :'/tweets/edit'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    if params[:content] != ""
      tweet = Tweet.find(params[:id])
      tweet.content = params[:content]
      tweet.save

      redirect "/tweets/#{tweet.id}"
    else
      redirect "/tweets/#{params[:id]}/edit"
    end
  end

  delete '/tweets/:id' do
    @tweet = Tweet.find(params[:id])

    if logged_in? && current_user.id == @tweet.user_id
      Tweet.delete(@tweet.id)
      redirect '/tweets'
    else
      redirect '/login'
    end
  end
end
