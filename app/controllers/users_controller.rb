class UsersController < ApplicationController

    get '/signup' do
        if !logged_in?
            erb :'/users/create_user'
        else
            
            redirect "/tweets"         
        end    
    end
        
    post '/signup' do
        @user = User.create(params)
        if @user.save
            session[:user_id] = @user.id
            redirect '/tweets'
        else
          redirect '/signup'
        end
    end

    get '/login' do
        if !logged_in?
            erb :'users/login'                   
        else
            redirect '/tweets'
        end
    end

    post '/login' do 
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])           
            session[:user_id] = @user.id
            redirect "/tweets"
        else
            erb :'/users/login'
        end
    end

    get '/show' do
        @user = User.find_by(username: params[:username])
        erb :'users/show'
      end

    get '/logout' do
        session.clear if logged_in?
        redirect '/login'
    end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        @tweets = @user.tweets
  
        erb :'users/show'
      end

end