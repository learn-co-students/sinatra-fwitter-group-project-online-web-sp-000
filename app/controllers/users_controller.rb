class UsersController < ApplicationController

    get '/signup' do
        if Helpers.logged_in?(session)
            redirect to '/tweets'
        else
            erb :'users/create_user'
        end
    end

    get '/login' do
        if Helpers.logged_in?(session)
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
            redirect to "/tweets"
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
            session.clear
            redirect to '/login'
        else
            redirect to '/'
        end
    end

end
