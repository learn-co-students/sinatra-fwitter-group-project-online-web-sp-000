class TweetsController < ApplicationController

  get '/tweets' do
    @tweets = Tweet.all 
    if logged_in?
      @user = current_user

      erb :'/tweets/index'
    else
      redirect to 'login'
    end
  end
 
end
