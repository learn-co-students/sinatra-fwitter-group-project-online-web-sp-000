class TweetsController < ApplicationController
  binding.pry

  get '/tweets' do

    binding.pry
      @tweets = Tweet.all
      erb :'/tweets/tweets'
  end

  get '/tweets/new' do
    erb :'/tweets/new'
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
