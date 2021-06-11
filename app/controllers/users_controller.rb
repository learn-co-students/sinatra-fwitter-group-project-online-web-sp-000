class UsersController < ApplicationController 

    get '/signup' do
        if !logged_in?
            erb :'users/signup'
        else
            redirect '/tweets'
        end
    end

    post '/signup' do
        if params[:username] == "" || params[:password] == "" || params[:email] == ""
          redirect '/signup'
        else
          user = User.create(username: params[:username], password: params[:password], email: params[:email])
          session[:user_id] = user.id
          redirect '/tweets'
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
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          redirect to '/tweets'
        else
          redirect to '/signup'
        end
    end

    get '/logout' do
        if logged_in?
          session.clear
          redirect to '/login'
        else
          redirect to '/'
        end
    end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'/users/show'
    end
  
end
