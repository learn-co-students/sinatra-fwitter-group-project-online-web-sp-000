class UsersController < ApplicationController

    get "/users/:slug" do 
        @view = "./users/show.erb"
        erb :"show"
    end 
end
