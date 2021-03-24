require 'pry'

class UsersController < ApplicationController

    get '/signup' do
        erb :'users/signup'
    end

    post '/signup' do
        user = User.create(params)
        if user.username.blank? || user.email.blank? || user.password.blank?
            redirect '/signup'
        else
            session[:user_id] = user.id
        #binding.pry
        end
        redirect '/tweets'
    end

    get '/login' do
        erb :'users/login'
    end

    post '/login' do
        user = User.find_by_username(params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect '/tweets'
        else
            redirect '/login'
        end
    end

    get '/users/:slug' do
        @user = User.find_by_slug(slug)
        erb :'users/show'
    end

    get '/logout' do
        session.clear
        redirect '/login'
    end

end
