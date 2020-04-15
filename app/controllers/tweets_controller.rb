class TweetsController < ApplicationController

  # get '/tweets' do
  #   erb :'/tweets/index'
  # end
  get '/tweets' do
    if logged_in?
      erb :'tweets/index'
    else
      redirect 'users/login'
    end
  end

end
