class UsersController < ApplicationController
    get '/signup' do
        if is_logged_in?
            redirect '/tweets'
        else
            erb :'/users/signup'
        end
    end
    
    post '/signup' do
        if !!User.find_by(username: params[:username]) # also check that username has no spaces and is alphanumeric except for underscores
            session[:failure] = 'signup'
            redirect '/failure'
        else
            User.create(:username => params[:username], :email => params[:email], :password => params[:password])
            redirect '/login'
        end
    end

    get '/login' do
        if is_logged_in?
            redirect '/tweets'
        else
            erb :'/users/login'
        end
    end

    post '/login' do
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect '/tweets'
        else
            session[:failure] = 'login'
            redirect '/failure'
        end
    end

    get '/logout' do
        session.clear
        redirect '/login'
    end

    get '/failure' do
        if !session[:failure]
            redirect '/'
        else
            @failure = session[:failure]
            session.delete(:failure)
            erb :'/users/failure'
        end
    end
end
