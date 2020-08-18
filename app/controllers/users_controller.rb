class UsersController < ApplicationController
    
    get '/login' do
        if !logged_in?
            erb :'/users/login'
        else 
            redirect to '/tweets'
        end
      end

    post '/login' do
        @user = User.find_by(:username => params[:username]) 
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect to '/tweets'
        else
            erb :'/users/login'
        end
    end

    get '/signup' do
        redirect '/tweets' if logged_in?
        erb :'/users/create_user'
    end

    post '/signup' do
        
        @user = User.new(params)
        if @user.save && !@user.email.empty? && !@user.username.empty?
            session[:user_id] = @user.id
			redirect "/tweets" 
		else
			redirect "/signup"
		end
    end

    get '/logout' do
        if logged_in?
            # erb :'/users/logout'  
            session.clear
        end
        redirect '/login'
    end

    get '/users/:user_id' do
        @tweets = User.find_by_slug(params[:user_id]).all
        erb :'/users/show'
    end

end
