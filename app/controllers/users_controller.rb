class UsersController < ApplicationController

    get '/signup' do 
        #binding.pry
        if !logged_in?
            erb :'users/signup'
        else 
            redirect '/tweets'
        end 
    end 
    
    post '/signup' do 
        #binding.pry
        if params[:username] == "" || params[:email] == "" || params[:password] == ""
            redirect '/signup'
        #elsif User.find_by(username: params[:username]) != nil 
           # redirect '/tweets'
        else 
            user = User.create(username: params[:username], email: params[:email], password: params[:password])
            user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect '/tweets'
        end
    end 

    get '/login' do 
        if logged_in?
            redirect '/tweets'
        else 
            erb :'users/login'
        end 
    end 

    post '/login' do 
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id 
            redirect '/tweets' 
        else 
            redirect '/signup'
        end 
    end 

    get "/logout" do
        session.clear
        redirect '/login'
    end

end
