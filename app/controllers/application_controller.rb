require './config/environment'
require 'pry'
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    erb :'users/signup'
  end

  post '/signup' do
   
    if params[:username] == ""
        redirect to '/signup'
    elsif params[:email] == ""
        redirect to '/signup'
    elsif params[:password] == ""
      redirect to '/signup'
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])

      redirect to '/tweets'
    end

  end

  get '/tweets' do
    erb :'/tweets/new'
  end

  get '/login' do
    erb :'users/login'
  end 

  post '/login' do

    # authenticate the password after you find the user
    # decrypts the password and then compare the password in the db

    @user = User.find_by(username: params[:username])

  
    if @user && @user.authenticate(params[:password])
      # authenticate the password 
      #then set the session ID
      session[:user_id] = @user.id
      
      redirect to '/tweets'
    end

    redirect to '/login'

  end

  post '/tweets' do

  end

end
