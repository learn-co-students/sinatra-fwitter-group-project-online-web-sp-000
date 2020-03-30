class TweetsController < ApplicationController
  get '/tweets' do
    erb :'tweets/index'
  end

end
