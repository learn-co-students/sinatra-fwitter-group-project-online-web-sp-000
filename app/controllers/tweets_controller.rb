class TweetsController < ApplicationController
  get '/tweets' do
    #binding.pry
    if logged_in?
      @user = User.find(session[:user_id])
      erb :tweets
    else
      redirect "/login"
    end
  end


    get '/tweets/new' do
    end

    post '/tweets' do
      @tweet = Tweet.create(params)
      erb :'tweets/show'
    end

    get '/tweets/:id' do
      erb :'tweets/show'
    end
    
end
