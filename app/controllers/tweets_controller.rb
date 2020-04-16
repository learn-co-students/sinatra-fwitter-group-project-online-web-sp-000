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
    else
      redirect 'users/login'
    end
  end

  post '/tweets' do

    if Helpers.is_logged_in?(session)
      if params["content"] == ""
        redirect 'tweets/new'
      else
        @tweet = Tweet.create(content: params["content"], user_id: session[:user_id])
        erb :'tweets/index'
      end
    end
  end


end
