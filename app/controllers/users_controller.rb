class UsersController < ApplicationController

    get '/login' do
        if logged_in?
            redirect '/tweets'
        else
            erb :"users/login"
        end
    end
    
    post '/login' do
        @user = User.find_by(username: params[:username])
        
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
        end
        redirect to '/tweets'
    end
   
    get '/signup' do
        if logged_in?
            redirect to "/tweets"
        else
            erb :"users/signup"
        end
    end

    post '/signup' do
        if params[:username] !="" && params[:email] !="" && params[:password] !=""
            @user = User.create(username: params[:username], email: params[:email], password: params[:password])
            session[:user_id] = @user.id
            redirect to "/tweets"
        else
            redirect to "/signup"
        end        
    end

    get '/logout' do
        if !logged_in?
            redirect to '/'
        else
            session.clear
            redirect to '/login'    
        end
    end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :"users/show"
    end

end
