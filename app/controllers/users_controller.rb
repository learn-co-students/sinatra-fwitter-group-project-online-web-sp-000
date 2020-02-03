class UsersController < ApplicationController

  get '/signup' do
    #binding.pry
    if session[:user_id] == nil
      erb :'/users/create_user'
    else
      binding.pry
      redirect to "/tweets"
    end
  end

  post '/signup' do
    if !params[:username].empty? && !params[:password].empty? && !params[:email].empty?
      @user = User.new(:username => params[:username], :password => params[:password], :email => params[:email])
      if @user.save
        redirect "/tweets"
      end
    else
      redirect "/signup"
    end
  end

  get '/login' do
    erb :'/users/login'
  end

  post "/login" do
    @user = User.find_by(:username => params[:username])
    if !params[:username].empty? && !params[:password].empty && !params[:email].empty && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  helpers do
    def current_user
      User.find(session[:user_id])
    end
  end

end
