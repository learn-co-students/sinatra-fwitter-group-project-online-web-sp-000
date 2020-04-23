class TweetsController < ApplicationController

    enable :sessions 

    get "/tweets" do 
        if !logged_in? 
            redirect :"/login"
        end
        @user = User.find(session[:user_id])
        @tweets = Tweet.all
        @view = "./tweets/index.erb"
        erb :"tweets/index"
    end

end
