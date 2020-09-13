class UsersController < ApplicationController

    get '/signup' do
        if !Helpers.is_logged_in?(session)
            erb :'users/create_user'
        else
            redirect to '/tweets'
        end
    end

    post '/signup' do
        # if user is not logged in, cannot view page
        if params[:email].empty? || params[:username].empty? || params[:password].empty?
            redirect to '/signup'
        
        else
            @user = User.create(email: params[:email], username: params[:username], password: params[:password])
            session[:user_id] = @user.id
            redirect '/tweets'
        end
    end

    get '/login' do
        #binding.pry
        if Helpers.is_logged_in?(session)
            redirect to '/tweets'
        else 
            erb :'users/login'
        end
    end

    post '/login' do
        
        @user = User.find_by(:username => params[:username])
        
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect '/tweets'
        end
        redirect to '/login'
    end

    get '/logout' do
        erb :'users/logout'
    end

    post '/logout' do
        if Helpers.is_logged_in?(session)
            session.clear
            redirect '/login'      
        end
    end

end