class TweetsController < ApplicationController

  get '/tweets' do
    erb :'tweets'
  end

end
