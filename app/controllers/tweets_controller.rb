class TweetsController < ApplicationController
    
    get "/tweets" do 
        
        if Helpers.is_logged_in?(session)
        
            erb :'tweets/tweets'

        else

            redirect "/login"

        end
    end

    get "/tweets/new" do
        erb :'tweets/new'
    end

    post "/tweets" do
        @user = User.find_by(id: session[:user_id])
        @tweet = Tweet.new(content: params[:content])
        @tweet.user = @user
        #binding.pry

        @tweet.save

    end

    # get "/tweets/:slug" do

    #     @user = User.find_by_slug(params[:slug])

    #     erb :'/show_tweet'

    # end


end
