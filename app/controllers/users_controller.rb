class UsersController < ApplicationController

    get '/signup' do
        if logged_in?
            redirect "/tweets" 
       
        else
            erb :'users/signup'  
        end
    end

    post '/signup' do 
        @user = User.new(params)
        if @user.save
        redirect "/tweets"
        else
            redirect '/signup'
        end
    end

    get '/login' do
        erb :'users/login'
    end

    post '/login' do
       #binding.pry
        user = User.find_by(:username => params[:username])
        if !!(user && user.authenticate(params[:password]))
            sessions[:user_id] = user.id
            redirect "/tweets"
        else
            redirect "/login"
        end
    end

    get '/users/:id' do

    end

end
