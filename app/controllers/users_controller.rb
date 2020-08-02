class UsersController < ApplicationController

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'/users/show'
    end 

    get '/signup' do 
        if is_logged_in?
          redirect to '/tweets'
        end 
        erb :'/users/signup'
    end 

    get '/login' do 
        if is_logged_in?
            redirect to '/tweets'
        end
        erb :'/users/login'
    end 

    get '/logout' do 
        if is_logged_in?
            session.clear 
            redirect to '/login'
        elsif !is_logged_in?
            redirect to '/index'
        end 
    end 
      
    post '/signup' do 
        if params[:username].empty? || params[:email].empty? || params[:password].empty? 
          redirect to '/signup'
        else 
          @user = User.create(params)
          session[:user_id] = @user.id
          redirect to '/tweets'
        end 
    end 

    post '/login' do 
        @user = User.find_by_username(params[:username])
        if @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect to '/tweets'
        else 
            redirect to '/signup'
        end 
    end 
    

end
