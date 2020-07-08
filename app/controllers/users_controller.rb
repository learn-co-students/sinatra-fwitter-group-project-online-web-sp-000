class UsersController < ApplicationController
    get '/signup' do
        if Helpers.is_logged_in?(session)
            redirect to '/tweets'
        else
            erb :'/users/create'
        end
    end

    get '/login' do
        if !Helpers.is_logged_in?(session)
            erb :'/users/login'
        else
            redirect to '/tweets'
        end
    end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'/users/show'
    end

    post '/signup' do
        if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
            user = User.new
            user.username = params[:username]
            user.email = params[:email]
            user.password = params[:password]
            user.save
            session[:user_id] = user.id
            redirect to '/tweets'
        else
            redirect to 'signup'
        end
    end

    post '/login' do
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
        end
        redirect to '/tweets'
    end

    get '/logout' do
        if Helpers.is_logged_in?(session)
            session.clear
        end
        redirect to '/login'
    end

    post '/logout' do
        if Helpers.is_logged_in?(session)
            session.clear
        end
        redirect to '/login'
    end
end
