class TweetsController < ApplicationController

  get '/tweets' do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      @tweets = Tweet.all
      erb :'tweets/index'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if Helpers.is_logged_in?(session)
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if params[:content].blank?
      redirect 'tweets/new'
    else
      user = Helpers.current_user(session)
      user.tweets << Tweet.new(content: params[:content])
      redirect "/users/#{user.slug}"
    end
  end

  get 'tweets/:id' do
      @tweet = Tweet.find_by(params[:id])

      erb :'tweets/show'
  end


end
