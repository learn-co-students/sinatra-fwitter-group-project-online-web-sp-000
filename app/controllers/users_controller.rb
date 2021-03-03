class UsersController < ApplicationController

    get "/signup" do
        erb :"users/create_user"
    end

    post "/signup" do
        redirect to "tweets/tweets"
    end



end
