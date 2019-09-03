class TweetsController < ApplicationController

get '/tweets' do
  if Helpers.is_logged_in?(session)

    erb :'tweets/tweets'
  else
    redirect '/login'
  end
end

get '/tweets/:id' do
  if !Helpers.is_logged_in?(session)
    redirect to '/login'
  else
    @tweet = Tweet.find(params[:id])
    redirect to '/tweets/show_tweet'
  end
end

get '/users/:slug' do
 @user = User.find_by(params[:slug])
end







end
