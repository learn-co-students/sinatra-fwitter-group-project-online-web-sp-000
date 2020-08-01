class UsersController < ApplicationController

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
        
    end 
    
    
end
