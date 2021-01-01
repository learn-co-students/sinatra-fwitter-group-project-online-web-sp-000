class TweetsController < ApplicationController

  get '/tweets' do
    if Helpers.is_logged_in?(session)
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      #redirect to "/login"
      erb :'users/login'
    end
  end

end
