class UsersController < ApplicationController

    enable :sessions
    set :session_secret, 'supersecret'

    get '/signup' do
        if Helpers.logged_in?(session)
            redirect to '/tweets'
        else
            erb :'users/create_user'
        end
    end

    get '/login' do
        if session[:user_id]
            redirect to '/tweets'
        else
            erb :'users/login'
        end
    end

    post '/signup' do
        if !params.values.include?("")
            new_user = User.create(username: params[:username], email: params[:email], password: params[:password])
            session[:user_id] = new_user.id
            redirect to "/tweets"
        else
            redirect to '/signup'
        end
    end

    post '/login' do
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect to "/users/#{user.slug}"
        else
            redirect to '/login'
        end
    end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'users/show'
    end

    get '/logout' do
        if Helpers.logged_in?(session)
            binding.pry
            erb :'users/logout'
        else
            binding.pry
            erb :'/'
        end
    end

    post '/logout' do
        session.clear
        redirect to '/login'
    end

end
