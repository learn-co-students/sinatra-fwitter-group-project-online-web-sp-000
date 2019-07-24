class TweetsController < ApplicationController

  get '/tweets' do
    @user = User.find(session[:user_id])
    erb :'/tweets/tweets'
  end

end
