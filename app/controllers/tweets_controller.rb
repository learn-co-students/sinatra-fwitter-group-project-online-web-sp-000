class TweetsController < ApplicationController

  get '/tweets' do
    redirect '/login' unless logged_in?

    @tweets = Tweet.all
    erb :'tweets/index'
  end

  get '/tweets/new' do
    redirect '/login' unless logged_in?

    @user = current_user

    erb :'tweets/new'
  end

  get '/tweets/:id' do
    redirect '/login' unless logged_in?

    @tweet = Tweet.find(params[:id])
    erb :'tweets/show'
  end

  get '/tweets/:id/edit' do
    redirect '/login' unless logged_in?

    @tweet = Tweet.find(params[:id])

    redirect "/tweets/#{@tweet.id}" unless current_user.id == @tweet.user.id

    erb :'tweets/edit'
  end

  post '/tweets' do
    redirect '/tweets/new' if params[:tweet][:content].empty?

    @tweet = Tweet.create(params[:tweet])
    @tweet.save

    redirect "/tweets/#{@tweet.id}"
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    redirect "/tweets/#{@tweet.id}" unless current_user.id == @tweet.user_id
    redirect "/tweets/#{@tweet.id}/edit" if params[:content].empty?
    @tweet.update(content: params[:content])
    @tweet.save

    redirect "/tweets/#{@tweet.id}"
  end

  delete '/tweets/:id' do
    @tweet = Tweet.find(params[:id])

    @tweet.destroy unless current_user.id != @tweet.user_id

    redirect '/tweets'
  end

end
