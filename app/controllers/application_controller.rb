require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions 
    set :session_secret, "secret"
  end

  get '/' do
      erb :homepage
  end
 
  get '/signup' do 
    if is_logged_in?
      
      redirect '/tweets'
    else
      
      erb :'/users/signup'
    end
  end

  post '/signup' do 
    if params[:username] == "" || params[:email]== "" || params[:password] == ""
     
      redirect '/users/signup'
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id

      redirect '/tweets'
    end
  end

  get '/login' do
    if is_logged_in?
      
      redirect '/tweets'
    else
      erb :'/users/login'        
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      
      redirect '/tweets'
    end
    
    redirect '/login'
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end

 
  
  




  helpers do 
    def current_user
     @user = User.find_by(id: session[:user_id])
    end
    
    def is_logged_in?
      !!current_user
    end

    
    
  end
 


end
