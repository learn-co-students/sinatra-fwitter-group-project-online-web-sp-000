class TweetsController < ApplicationController

  get '/tweets' do
    if Helpers.is_logged_in?(session)
      erb :'tweets/index'
    else
      redirect 'users/login'
    end
  end

  get '/tweets/new' do
    if Helpers.is_logged_in?(session)
      erb :'tweets/new'
    end
  end


end
