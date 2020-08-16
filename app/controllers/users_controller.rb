class UsersController < ApplicationController
    get '/users/new' do
        erb :'/users/new'
    end

    post '/users' do
        user = User.new(:email => params[:email], :username => params[:username], :password => params[:password])
        if (params[:email] == "" || params[:username] == "" || params[:password] == "")
            redirect '/users/failure'
        elsif (user.save)
            redirect '/users/login'
        else 
            redirect '/users/failure'
        end
    end

    get '/users/login' do
        erb :'/users/login'
    end

    post '/users/login' do
        user = User.find_by(email: params[:email])
        if (params[:username] == "" || params[:password] == "")
            redirect '/users/failure'
        elsif (user && user.authenticate(params[:password]))
            session[:user_id] = user.id
            redirect '/users/show'
        else
            redirect '/users/failure'
        end
    end

    get '/users/show' do
        @user = User.find(session[:user_id])
        if (@user)
            erb :'/users/show'
        else
            redirect '/users/login'
        end
    end

    get '/users/logout' do
        session.clear
        redirect '/users/login'
    end

    get '/users/failure' do
        erb :'/users/failure'
    end
end
