require 'pry'
class UsersController < ApplicationController

    get '/signup' do
        if logged_in?
          redirect to '/tweets'
        end
        erb :'/users/create_user'
    end 

    post '/signup' do 
        params.each do |label, input|
            if input.empty?
                redirect to "/signup"
            end 
        end 

        @user = User.new(username: params[:username], email: params[:email], password: params[:password])
        @user.save
        session[:user_id] = @user.id
        redirect to "/tweets"
    end 

    get '/login' do 
        if logged_in?
            redirect to '/tweets'
        end 
        erb :'/users/login'
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

end
