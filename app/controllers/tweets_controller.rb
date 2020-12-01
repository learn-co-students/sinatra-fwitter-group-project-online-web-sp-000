class TweetsController < ApplicationController

    get "/tweets" do
        @tweets = Tweet.all
        if Helper.is_logged_in?(session)
            erb :"/tweets/index"
        else
            erb :"/users/login"
        end
    end

    get "/tweets/:id" do
        @tweet = Tweet.find(params[:id])
        erb :'/tweets/show'
    end

end
