require 'pry'

class UsersController < ApplicationController

  get '/signup' do
    if logged_in? && current_user
      redirect to '/tweets'
    else
      erb :'/users/signup'
    end
  end

  post '/signup' do

    if params[:username] == "" || params[:password] == "" || params[:email] == ""
			redirect to '/signup'
		else
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
			redirect to '/tweets'
		end
  end

  get '/login' do
    if logged_in? && current_user
      redirect to '/tweets'
    else
      erb :'users/login'
    end
  end

  post '/login' do

    @user = User.find_by(:username => params[:username])
    # @user = User.find_by(username: params[:username], password: params[:password])
    # binding.pry

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    @tweets = @user.tweets
    erb :'/show'
  end

  get '/logout' do
    if logged_in? && current_user
      session.clear
		  redirect to"/login"
    else
      redirect to '/'
    end
  end
end
