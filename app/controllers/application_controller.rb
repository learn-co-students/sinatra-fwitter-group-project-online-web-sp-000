require './config/environment'
require 'pry'
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter_secret"
  end

  get '/' do
    erb :index
  end
 
    get '/signup' do
    if Helpers.is_logged_in?(session)
      # the user does not get redirected here
        redirect to '/tweets'
      else
        erb :'users/signup'
      end
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
      session[:user_id] = @user.id 
     
     # binding.pry
     
      erb :'/tweets/new'
    end

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

  post '/logout' do
    session.clear
    redirect to '/login'
  end



end