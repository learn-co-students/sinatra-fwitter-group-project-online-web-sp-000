require './config/environment'
require 'pry'
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions 
    set :session_secret, 'secret'
  end
 

  get '/' do 
    erb:'/homepage'
  end 

  get '/signup' do 
     if logged_in?
        redirect to "/tweets"
     else 
      erb:'/signup'
     end 
  end 

  post '/signup' do 
    if params[:username] != "" && params[:email] != "" && params[:password] != "" && !logged_in?
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id 
      redirect to '/tweets'
    else  
      redirect to '/signup'
    end 
    
  end 

  get '/login' do 
    if !logged_in? 
      erb:"/users/login"
    else 
      redirect to '/tweets'
    end 
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

  get '/tweets' do 
      @tweets = Tweet.all 
    if logged_in?
      erb:'tweets/index' 
    else 
      redirect to "/login"
    end 
  end

  get '/logout' do 
    if logged_in?
      session.clear 
      redirect to "/login"
    else 
      redirect to "/"
    end 
  end 

  get '/users/:id' do  
    @user = User.find_by(username: params["id"])
    erb:"/users/show"
  end 

  get '/users/:slug' do 
    
  end 


  helpers do 
    
    def current_user 
      @user = User.find_by(session["user_id"])
    end 

    def logged_in?
      if session[:user_id]
        true 
      else 
        false 
      end 
    end
  end  

end

