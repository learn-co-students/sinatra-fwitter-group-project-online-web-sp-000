class UsersController < ApplicationController
    get '/signup' do
        if is_logged_in?
            redirect '/tweets'
        else
            erb :'/users/signup'
        end
    end
    
    post '/signup' do
        User.create(:username => params[:username], :email => params[:email], :password => params[:password])
        redirect '/login'
    end

    get '/login' do
        if is_logged_in?
            redirect '/tweets'
        else
            erb :'/users/login'
        end
    end

    post '/login' do
        if params[:username].length == 0 || params[:password].length == 0
            redirect '/failure'
        else
            user = User.find_by(username: params[:username])
       
            if user && user.authenticate(params[:password])
                session[:user_id] = user.id
                redirect '/tweets'
            else
                redirect '/failure'
            end
        end      
    end

    get '/failure' do
        erb :'/users/failure'
    end

    get '/logout' do
        session.clear
        redirect '/login'
    end    
end
