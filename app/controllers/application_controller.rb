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

