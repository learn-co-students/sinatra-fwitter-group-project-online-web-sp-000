class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/new'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    erb :'/tweets/new'
  end

  get '/tweets/:id' do
   if logged_in?
     @tweet = Tweet.find_by_id(params[:id])
     erb :'tweets/show_tweet'
   else
     redirect to '/login'
   end
 end

  get '/tweets/:id/edit' do
    erb :'/tweets/edit_tweet'
  end

  post '/tweets/:id' do

  end
  post '/tweets/:id/delete' do

 end

end
