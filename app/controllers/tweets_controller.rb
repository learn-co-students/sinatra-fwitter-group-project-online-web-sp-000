class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
    @user = User.find(session[:user_id])
    erb :'/tweets/tweets'
  else
    redirect '/login'

  end
  end

end
