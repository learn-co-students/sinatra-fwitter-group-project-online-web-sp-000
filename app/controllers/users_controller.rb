class UsersController < ApplicationController

    get "/signup" do
        erb :"users/create_user"
    end

    post "/signup" do
        @user = User.new(username: params["username"], email: params["email"], password: params["password"])
        @user.save
        session[:user_id] = @user.id

        redirect to "tweets/tweets"
    end



end
