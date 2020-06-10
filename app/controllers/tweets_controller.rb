class TweetsController < ApplicationController
  before '/tweet*' do
    authentication_required
  end

  get '/tweets' do
    @user = current_user
    erb :'tweets/tweets'
  end

  get '/tweets/new' do
    erb :'tweets/new'
  end

  post '/tweets' do
    if params[:content].empty?
      redirect '/tweets/new'
    end
    params[:user_id] = current_user.id
    new_tweet = Tweet.create(params)
    redirect '/tweets'
  end
end
