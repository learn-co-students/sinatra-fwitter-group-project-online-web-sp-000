class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end


  get '/tweets/new' do

    erb :'/tweets/new'
  end

  post '/tweets' do
    @tweet = Tweet.create(params[:content])
    @tweet.user = User.create(user[:username], user[:email], user[:password])

  end

 

end
