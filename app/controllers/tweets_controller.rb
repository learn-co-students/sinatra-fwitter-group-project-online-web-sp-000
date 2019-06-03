class TweetsController < ApplicationController

  get '/tweets' do
    erb :'/tweets/show'
  end
end
