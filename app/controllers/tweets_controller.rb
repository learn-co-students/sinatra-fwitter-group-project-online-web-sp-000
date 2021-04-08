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

        if !params[:content].empty?

        @user = User.find_by(id: session[:user_id])
        @tweet = Tweet.new(content: params[:content])
        @tweet.user = @user
        @tweet.save

        else
            @error = "You need to add content to create a tweet!"

            redirect "/tweets/new"
        end

    end

    # get "/tweets/:slug" do

    #     @user = User.find_by_slug(params[:slug])

    #     erb :'/show_tweet'

    # end


end
