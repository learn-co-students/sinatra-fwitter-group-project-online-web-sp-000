class UsersController < ApplicationController
    
    #get '/signup' do
    #    if !!session[:user_id]
    #        redirect '/tweets'
    #    else
    #        erb :'/users/create_user'
    #    end
    #end
    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'users/show'
    end


    get '/signup' do
        if !session[:user_id]
          erb :'users/create_user', locals: {message: "Please sign up before you sign in"}
        else
          redirect to '/tweets'
        end
    end

    post '/signup' do
        if params[:username] == "" || params[:email] == "" || params[:password] == ""
          redirect to '/signup'
        else
          @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
          @user.save
          session[:user_id] = @user.id
          
          redirect '/tweets'
          
        end
    end

    get '/login' do
        if logged_in? 
            redirect "/tweets"
        else
            erb :'/users/login'
        end
    end

    post '/login' do
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect '/tweets'
            binding.pry
        else 
            redirect "/signup"
        end
    end

    get '/logout' do
        if logged_in?
            session.destroy
            redirect '/login'
        else
            redirect '/'
        end
    end

    post '/logout' do
        session.destroy
        redirect "/login"
    end
end
