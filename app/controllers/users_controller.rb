require_relative './tweets_controller'
class UsersController < ApplicationController

    get '/signup' do
        erb :"users/signup"
    end

    post '/signup' do
        user = User.new(params)
        if !user.save
          redirect to  "/signup"
        else
          session[:user_id] = user.id
          redirect "/tweets"
        end
    end

    get '/login' do
        if logged_in?
          redirect "/tweets"
        else
          erb :"users/login"
        end
    end

    post '/login' do
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password]) 
            session[:user_id] = user.id
            redirect "/tweets"
        else
            redirect "/login"
        end

    end
    
    get '/logout' do
        
        if logged_in?
            erb :"users/logout"
            session.clear
            redirect "/login"
        else
            redirect "/"
            
        end

    end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :"users/show"
    end

  

  


end
