class TweetsController < ApplicationController

  get('/tweets') { login_redirect; @tweets = Tweet.all; erb :'tweets/tweets' }
  get('/tweets/new') { login_redirect; erb :'tweets/new' }
  get('/tweets/:id') { login_redirect; @tweet = Tweet.find_by_id(params[:id]); erb :'tweets/show_tweet' }

  get '/tweets/:id/edit' do
    login_redirect
    @tweet = Tweet.find_by_id(params[:id])
    erb :'/tweets/edit_tweet' if @tweet && @tweet.user_id == current_user.id
  end

  post '/tweets' do
    login_redirect
    redirect_if('tweets/new', params[:content].empty?)
    @tweet = Tweet.new(content: params[:content])
    @user = current_user
    @user.tweets << @tweet
    redirect_if("/tweets/#{@tweet.id}", @user.save)
    redirect 'tweets/new'
  end

  patch '/tweets/:id' do
    login_redirect
    redirect_if("/tweets/#{params[:id]}/edit", params[:content].empty?)
    @tweet = Tweet.find_by_id(params[:id])
    redirect_if("/tweets/#{@tweet.id}", @tweet && @tweet.user == current_user && @tweet.update(content: params[:content]))
    redirect "/tweets/#{@tweet.id}/edit"
  end

  delete '/tweets/:id/delete' do
    login_redirect
    @tweet = Tweet.find_by_id(params[:id])
    (@tweet.destroy; redirect '/tweets') if @tweet && @tweet.user_id == current_user.id
  end

end
