require 'pry'
class UsersController < ApplicationController

  get '/' do
    erb :index
  end

  get '/index' do
    erb :index
  end
  
  get '/signup' do
    erb :'users/create_user'
  end

  post '/signup' do
    #binding.pry
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if @user && !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
      @user.save
      session[:user_id] = @user.id
      redirect to '/login'
    else
      #flash[:message] = "You need an username, an email, and a password to signup."
      redirect to '/signup'
    end
  end

  post '/login' do
    # binding.pry
    @user= User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/login'
    else
      #flash[:message] = "Invalid username or password."
      redirect to '/index'
    end
  end

  get '/login' do
    #binding.pry
    if Helpers.is_logged_in?(session)
      redirect to "/tweets"
    else
      erb :index
    end
  end

  #Profile Page
  get "/users/:slug" do
  #get '/users/:slug'do
    @user= User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  get '/logout' do
    erb :'users/logout'
  end

  post '/logout' do
    session.clear
    #flash[:message] ="You have been successfully logged out."
    redirect to '/index'
  end


end
