class UsersController < ApplicationController

    get '/signup' do
        if session[:user_id]
          redirect to '/tweets'
        end 
    
        erb :'/users/new'
    end
    
    post '/signup' do 
        if  params.values.any?("")
            redirect to '/signup'
        end 
        @user = User.create(params)
        session[:user_id] = @user.id
        redirect to '/tweets'
    end 

    get '/login' do 
        if session[:user_id]
            redirect to '/tweets'
        end
    
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
        if session[:user_id] 
            erb :'/users/logout'
        end
        redirect to '/login'
    end

    post '/logout' do
        session.clear
        redirect to '/login'
    end 

    get '/users/:id' do
        @user = User.find(params[:id])
        erb :'/users/show' 
    end 

end
