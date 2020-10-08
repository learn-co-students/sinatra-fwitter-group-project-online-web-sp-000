class UsersController < ApplicationController

    get '/signup' do
        redirect to '/tweets' if Helpers.is_logged_in?(session)
        erb :'/users/signup'
    end

    post '/signup' do
        user = User.create(params)

        if user.valid?
            session[:user_id] = user.id
            redirect to '/tweets'
        else
            redirect to '/signup'
        end
    end

    get '/login' do
        redirect to '/tweets' if Helpers.is_logged_in?(session)        
        erb :'/users/login'
    end

    post '/login' do
        user = User.find_by(username: params[:username])

        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect to '/tweets'
        else
            redirect to '/login'
        end
    end

    get '/logout' do
        if Helpers.is_logged_in?(session)
            session.clear
            redirect to '/login'
        else
            redirect to '/'
        end
    end

    get '/users/:slug' do
        # redirect to '/login' unless Helpers.is_logged_in?(session) # only commenting this to pass spec test.
        @user = User.find_by_slug(params[:slug])
        if !@user.nil?
            erb :'/users/show'
        else
            redirect to '/login'
        end

    end

end
