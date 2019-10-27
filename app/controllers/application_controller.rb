require './config/environment'
require 'pry'
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions 
    set :session_secret, 'secret'
  end

  helpers do

  end

  get '/' do 
    erb:'/homepage'
  end 

  get '/signup' do 
      erb:'/signup'
  end 

  post '/signup' do 
    if params[:username] != "" && params[:email] != "" && params[:password] != "" 
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id 
      redirect to '/tweets'
      else  
      redirect to '/signup'
    end 
  end 

  get '/login' do  
    erb:'/login'
  end 

  get '/tweets' do 
    if session[:user_id]

    end 
  end



end
