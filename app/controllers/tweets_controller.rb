class TweetsController < ApplicationController

  get '/tweets' do
    binding.pry
    if logged_in?
      @tweet = Tweet.all
      @user = current_user
      erb :'tweets/index'
    else
      redirect '/login'
    end
  end

  # get '/tweets/new' do
  #   if logged_in?
  #     erb :'/tweets/new'
  #   else
  #     redirect '/login'
  # end
  #
  # post '/tweets' do
  #
  # end
end
