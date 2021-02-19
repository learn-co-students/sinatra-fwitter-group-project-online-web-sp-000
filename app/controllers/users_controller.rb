class UsersController < ApplicationController

    get '/signup' do
        if logged_in?
            redirect to("/tweets")
        else
            erb :'users/create_user'
        end
    end

    post '/signup' do
        if params[:username].empty? || params[:email].empty? || params[:password].empty?
            redirect to("/signup")
        else 
            @user = User.create(username: params[:username], email: params[:email], password: params[:password])
            session['user_id'] = @user.id
        end

        @user.save
        redirect to("/tweets")
    end
  
    get '/login' do
        if logged_in?
            redirect to("/tweets")
        else
            erb :'users/login'
        end
    end

    post '/login' do
        @user = User.find_by(:username => params[:username])
        session['user_id'] = @user.id
        redirect to("/tweets")
    end

    get '/logout' do
        session.clear
        redirect to('/login')
    end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        @tweets = Tweet.all
        erb :'users/show'
    end
end
