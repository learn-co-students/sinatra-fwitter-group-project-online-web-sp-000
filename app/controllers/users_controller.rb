class UsersController < ApplicationController

    get '/signup' do
        erb :'/users/create_user'
    end

    post '/signup' do
        @user = User.new
        @user.username = params[:username]
        @user.email = params[:email]
        @user.password = params[:password]
        redirect '/tweets/tweets'
    end
end
