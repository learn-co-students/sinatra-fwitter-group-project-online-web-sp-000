class UsersController < ApplicationController
    get '/users/signup' do
        erb :'/users/new'
    end

    post '/users' do
        @user = User.create(username: params[:username], password: params[:password])
        session[:user_id] = @user.id
        @session = session
        redirect to '/tweets'
    end

    get '/user/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'/users/show'
    end

end
