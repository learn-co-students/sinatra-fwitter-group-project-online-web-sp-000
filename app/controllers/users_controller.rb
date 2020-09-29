class UsersController < ApplicationController

    get '/signup' do
        if logged_in?
            redirect '/tweets'
        else
            erb :'/users/create_user'
        end
    end

    post '/signup' do
        if params[:username] == "" || params[:email] == "" || params[:password] == ""
            redirect to '/signup'
        else
            @user = User.create(username: params[:username], email: params[:email], password: params[:password])
            session[:id] = @user.id
            redirect to '/tweets'
        end
    end

    get '/login' do
        if logged_in?
            redirect "/tweets"
        else
            erb :'users/login'
        end
    end

    post '/login' do
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            session[:id] = @user.id
            redirect '/tweets'
        else
            redirect '/login'
        end
    end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :"/users/show"
    end

    get '/logout' do
        session.clear
        redirect '/login'
    end

end
