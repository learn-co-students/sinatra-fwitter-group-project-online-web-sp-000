require 'pry'

class UsersController < ApplicationController

  get '/signup' do 
    erb :'/users/signup'
  end

  post '/signup' do
      @user = User.new(username: params[:username], email: params[:email], password: params[:password])
      if @user.save
          session[:user_id] = @user.id
          redirect "/"
      else 
          redirect '/signup'
      end
  end

  get '/login' do 
    erb :"/users/login"
  end

  post '/users/login' do
    if is_logged_in?
      redirect "/"
    else 
      @user = User.find_by(email: params[:email])

      if @user && @user.authenticate(params[:password])
          session[:user_id] = @user.id
      end 
      
      redirect "/"
    end
  end

end
