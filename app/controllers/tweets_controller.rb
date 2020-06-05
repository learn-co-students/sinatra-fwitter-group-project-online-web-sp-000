class TweetsController < ApplicationController
    get "/tweets" do

        if User.is_logged_in?(session)
            @tweets = Tweet.all
            # @tweets_with_user = {}
            # @tweets.each_with_index do |t,i|
            #     binding.pry
            #     user = User.find_by_id(t.user_id).username
            #     @tweets_with_user[i] = [:name => user, :content => t.content]
            # end
            @user = User.find_by_id(session[:user_id])
            erb :"/tweets/index"
        else
            redirect "/login"
        end
    end

    get "/tweets/new" do
        if User.is_logged_in?(session)
            @user = User.find_by_id(session[:user_id])
            binding.pry
            @tweet = Tweet.create(params)
            @tweet.user_id = @user.id
            @tweet.save
        end
        redirect "/tweets"
    end      
end
