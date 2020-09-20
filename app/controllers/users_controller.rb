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

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'/users/show'
    end

    get '/login' do
        erb :'/users/login'
    end

    post '/login' do
        user = User.find_by(:username => params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect "/users/#{user.slug}"
        else
            redirect '/users/login'
        end
    end


end
