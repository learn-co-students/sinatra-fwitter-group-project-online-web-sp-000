class TweetsController < ApplicationController

 get '/tweets' do
    @tweets = Tweet.all
   # binding.pry
    if !logged_in?
        erb :'users/login'
    else
        @user = current_user
    erb :'tweets/tweets'
    end
 end

end
