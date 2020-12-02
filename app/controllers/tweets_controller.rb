class TweetsController < ApplicationController

    get "/tweets" do
        if !Helper.is_logged_in?(session)
            redirect to '/login'
        end
        @tweets = Tweet.all
        @user = Helper.current_user(session)
        erb :"/tweets/tweets"
    end

    get "/tweets/:id" do
        @tweet = Tweet.find(params[:id])
        erb :'/tweets/show'
    end

end
