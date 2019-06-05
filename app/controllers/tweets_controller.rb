class TweetsController < ApplicationController

  get '/tweets' do
    binding.pry
    if !logged_in?(session)
      redirect "/login"
    end
    @user = current_user(session)
    @tweets = Tweet.all
    # binding.pry
    erb :'/tweets/index'
  end

  get '/tweets/new' do
    if !logged_in?(session)
      redirect "/login"
    end
  erb :'/tweets/new'
  end

  get '/tweets/:id' do

  erb :'tweets/show'
  end

  post '/tweets' do
    @tweet = Tweet.create(:content => params[:content])
    @tweet.user_id = current_user(session).id
    @tweet.save


    redirect "/tweets/#{@tweet.id}"
  end
end
