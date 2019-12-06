require './config/environment'
require 'pry'
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
  end

  get '/' do
    erb :index
  end

# @user =  Helpers.current_user(session)
# @user = @user.find(session[:user_id])   # finding the id for the current user
# @user.tweets # all the tweets that belong to the user  
# @tweets.each do |t|

  get '/signup' do
   if Helpers.is_logged_in?(session)

      redirect '/tweets'

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

      redirect to '/tweets'
    end

  end

  get '/tweets' do
   
    binding.pry

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