class UsersController < ApplicationController

    get '/' do
      erb :index
    end

    get '/signup' do
        # binding.pry
        if !logged_in?
            erb :'users/signup'
        else
            redirect to '/tweets'
        end
    end

    post '/signup' do
        if params[:username] == "" || params[:email] == "" || params[:password] == ""
            redirect to '/signup'
        end

        @user = User.new(params)
        @user.save
        session[:user_id] = @user.id
        # binding.pry
        redirect to '/tweets'
    end

    get '/login' do
        erb :'users/login'

    end


    post '/login' do


    end


    get '/logout' do
        session.clear
        erb :users/login
    end





end
