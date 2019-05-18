class TweetsController < ApplicationController

  get '/tweets' do

    if Helpers.is_logged_in?(session)
      @user = User.find(session[:user_id])
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

end
