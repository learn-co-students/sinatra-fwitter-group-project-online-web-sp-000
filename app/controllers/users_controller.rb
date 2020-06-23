class UsersController < ApplicationController

    get '/users' do
        @users = User.all
        erb :'/users/index'
    end
end
