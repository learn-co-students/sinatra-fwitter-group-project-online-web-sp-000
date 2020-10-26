class UsersController < ApplicationController

    get '/signup' do
        if session[:id]
            redirect "/tweets"
        else
            erb :"users/signup"
        end
    end

    post '/signup' do
        if params[:username].empty? || params[:email].empty? || params[:password].empty?
            redirect "/signup"
        else
            user = User.new(params)
            user.save
            session[:id] = user.id
            redirect "/tweets"
        end
    end

    get '/login' do
        if logged_in?
            redirect "/tweets"
        else
            erb :"users/login"
        end
    end

    post '/login' do
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:id] = user.id
            redirect "/tweets"
        else
            redirect "/signup"
        end
    end

    get '/logout' do
        if logged_in?
            session.clear
            redirect to "/login"
        elsif !logged_in?
            redirect to "/"
        end
    end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'users/show'
    end
end
