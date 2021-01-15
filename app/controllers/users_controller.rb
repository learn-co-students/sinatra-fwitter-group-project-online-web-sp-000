class UsersController < ApplicationController

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'users/show'
    end

    get '/login' do
        if !logged_in?
            erb :login
        else
            redirect '/tweets'
        end
    end

    post '/login' do
        @user = User.find_by(username: params[:username])

        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect '/tweets'
        else
            redirect '/'
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
        @user = User.create(params)
        if params[:username] == "" || params[:email] == "" || params[:password] == ""
            redirect '/signup'
        else
            session[:user_id] = @user.id
            redirect '/tweets'
        end
    end

    get '/logout' do
        if logged_in?
            session.destroy
            redirect '/login'
        else
            redirect '/'
        end
    end

end
