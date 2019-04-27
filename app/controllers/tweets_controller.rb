class TweetsController < ApplicationController
  get '/tweets' do
    if logged_in?
      @user = User.find(session[:user_id])
      erb :'tweets/index'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do

    erb :'tweets/new'
  end

  get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])

    erb :'tweets/show'
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])

    erb :'tweets/edit'
  end

  post '/tweets' do
    erb :'tweets/index'
  end

  post '/tweets/:id/delete' do
    tweet = Tweet.find(params[:id])
    tweet.destroy
  end

  patch '/tweets' do
    tweet = Tweet.find(params[:id])
    tweet.content = params[:tweet][:content]

    redirect "/tweets/#{tweet.id}"
  end
end
