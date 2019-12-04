class TweetsController < ApplicationController

 get '/tweets' do
   if !is_logged_in?(session)
      redirect to '/login'
    end
    @tweets = Tweet.all
    @user = current_user(session)
   erb :'tweets/tweets'
 end

end
