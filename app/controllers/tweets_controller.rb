class TweetsController < ApplicationController

  get '/tweets' do
    if !logged_in?
      redirect to '/login'
    end
    @tweets = Tweet.all
    erb :'/tweets/tweets'
  end


  get '/login' do
    erb :'users/login'
  end

  get '/tweets/new' do
    erb :'/tweets/new'
  end

  post '/tweets' do
    erb :'/tweets/new'
  end

  get '/tweets/:id' do
    erb :'/tweets/show_tweet'
  end

  get '/tweets/:id/edit' do
    erb :'/tweets/edit_tweet'
  end

  post '/tweets/:id' do

  end
  post '/tweets/:id/delete' do

 end

end
