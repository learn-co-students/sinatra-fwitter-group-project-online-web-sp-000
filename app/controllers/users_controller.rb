class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      #binding.pry
      redirect to "/tweets"
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do

    if !params[:username].empty? && !params[:password].empty? && !params[:email].empty?
      binding.pry

      @user = User.new(:username => params[:username], :password => params[:password], :email => params[:email])

      @user.save
      session[:user_id] = @user.id

      redirect to "/tweets"
    else
      redirect to "/signup"
    end
  end

  get '/login' do
    if logged_in?
      redirect to "/tweets"
    else
      erb :'/users/login'
    end
  end

  post "/login" do
    @user = User.find_by(:username => params[:username])
    if !params[:username].empty? && !params[:password].empty? && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "/tweets"
    else
      redirect to "/login"
    end
  end

  get "/logout" do
    session.clear
    redirect "/login"
  end

  get "/users/:slug" do
    binding.pry
  end

end
