class TweetsController < ApplicationController

    get '/tweets' do
        # tweets index page
        # display all tweets for logged in user and other users
        # if a user is not logged in, redirect to '/login'
        if logged_in?
          @tweets = Tweet.all
          erb :'tweets/tweets'
        else
          redirect to '/login'
        end
      end

end
