class UsersController < ApplicationController
    get "/users/:slug" do
        @user = user.find_by_slug(params[:slug])
        erb :"users/show"
    end

end
