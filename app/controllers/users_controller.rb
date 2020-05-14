class UsersController < ApplicationController

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'users/show'
      end

    get '/signup' do
        if !logged_in?
            erb :'/users/signup'
        else
            redirect to '/tweets'
        end
    end

    get '/login' do
        if !logged_in?
            erb :'users/login'
        else
            redirect to '/tweets'
        end
    end

    post '/login' do
        user = User.find_by(:username => params[:username])
        if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          redirect to "/tweets"
        else
          redirect to '/signup'
        end
      end

    post '/signup' do
        if params[:username] == "" || params[:email] == "" || params[:password] == ""
          redirect to '/signup'
        else
          @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
          @user.save
          session[:user_id] = @user.id
          redirect to '/tweets'
        end
      end

    get '/users' do
        erb :'/users/show'
    end

    post '/users' do
        @user = User.create(params)
        if @user.save 
            session[:user_id] = @user.id
            redirect "/tweets"
        else
            redirect '/signup'
        end
    end

    get '/users/:id' do
        erb :'/users/show'
    end

    get '/logout' do
        session.clear
        redirect'/login'
    end


end
