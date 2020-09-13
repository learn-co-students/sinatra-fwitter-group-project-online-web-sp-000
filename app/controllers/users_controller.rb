class UsersController < ApplicationController

    get '/signup' do
        #binding.pry
        if logged_in?
            redirect to '/tweets'
        else
            erb :'users/create_user'
        end
    end

    post '/signup' do
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
        if logged_in?
            redirect '/tweets'
        else 
            erb :'/users/login'
        end
    end

    post '/login' do
        @user = User.find_by(username: params[:username])
        
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect to '/tweets'
        else
            redirect to '/login'
        end
    end

    get '/logout' do
        if logged_in?
            session.clear
            redirect '/login'
        else
            redirect '/'
        end
    end

    #post '/logout' do
    #    binding.pry
    #    session.clear
    #    redirect '/login'      
   # end

end