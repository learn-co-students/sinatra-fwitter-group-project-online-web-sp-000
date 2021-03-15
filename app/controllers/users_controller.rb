class UsersController < ApplicationController

    get '/signup' do
        erb :'/users/signup'
    end

    post '/signup' do
        #binding.pry
        if params[:user]["email"] == "" || params[:user]["username"] == "" || params[:user]["password"] == ""
            redirect to "/signup"
        else
            @user = User.new(:email => params[:email], :username => params[:username], :password => params[:password])
            @user.save
            session[:user_id] = @user.id
            redirect to "/tweets"
        end
    end

    get '/login' do
        erb :'/users/login'
    end

    post '/login' do
        @user = User.find_by(params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect "/tweets"
        else
            redirect "/failure"
        end
    end

    get "/failure" do
        erb :failure
    end

    get '/logout' do
        session.clear
        redirect "/"
    end

end
