class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      erb :"/tweets/tweets"
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    erb :"tweets/new"
  end

  post '/tweets' do

    redirect "/tweets/:id"
  end

  get '/tweets/:id' do
  end 

end
