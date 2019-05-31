class TweetsController < ApplicationController

  get '/tweets/new' do
    erb :'/tweets/new'
  end

  get '/tweets' do
      erb :'/tweets/tweets'
  end

  post '/tweets' do

  end

  get '/tweets/:id' do
    erb :'/tweets/show'
  end

  get '/tweets/:id/edit' do

  end

  post '/tweets/:id' do

  end

  delete '/tweets/:id/delete' do

  end
end
