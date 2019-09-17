class UsersController < ApplicationController

    get '/login' do
        if !logged_in?
            erb :login
        else
            redirect '/tweets'
        end
    end

    post '/login' do
        @user = User.find_by(username: params[:username])
        if @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect to "/tweets"
        else
            redirect "/login"
        end
    end

    get '/signup' do
        if !logged_in?
            erb :signup
        else
            redirect '/tweets'
        end
    end

    post '/signup' do
        if params[:username] != "" && params[:email] != "" && params[:password] != ""
            @user = User.create(params)
            session[:user_id] = @user.id
            redirect to "/tweets"
        else
            redirect '/signup'
        end
    end

    get '/users/:slug' do
        @user = current_user
        erb :"users/show"
    end

    get '/logout' do
        if logged_in?
            session.clear
            redirect '/login'
        else
            redirect '/login'
        end
    end

    post '/logout' do
        session.clear
        redirect '/login'
    end
end
