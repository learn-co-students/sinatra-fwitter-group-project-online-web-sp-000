class UsersController < ApplicationController

    get '/signup' do
        if !logged_in?
            erb :'users/create_user'
        else
            redirect to '/tweets'
        end 
    end

    post '/signup' do
        if params[:username] != "" && params[:email] != "" && params[:password] != ""
            @user = User.create(username: params[:username], email: params[:email], password:params[:password] )
            session[:user_id] = @user.id
            redirect to "/tweets"
        else
            redirect to '/signup'
        end
    end

    get '/login' do
        if !logged_in?
            erb :'users/login'
        else
            redirect to '/tweets'
        end
    end

    post '/login' do
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect to '/tweets'
        else
            redirect to '/signup'
        end
    end

    get '/logout' do
        if logged_in?
             session.destroy
             redirect to '/login'
        else
             redirect to '/'
        end
    end

    get '/users/:user' do
        @user = User.find_by_slug(params[:user])
        erb :'users/show'
    end


end
