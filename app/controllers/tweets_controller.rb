class TweetsController < ApplicationController

    get '/tweets' do
        #if !Helpers.is_logged_in?(session)
            #redirect to '/login'
        #end
          @tweets = Tweet.all
          #@user = Helpers.current_user(session)
          erb :"/tweets/index"
    end



end
