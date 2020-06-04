class TweetsController < ApplicationController
    get "/tweets" do

        if session[:user_id]
            @tweets = Tweets.all
            @user = User.find_by_id(sessions[:user_id])
            erb :"/tweets/index"
        else
            erb :"/users/signup"
        end
    end

end
