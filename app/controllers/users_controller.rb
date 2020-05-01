class UsersController < ApplicationController

  get '/signup' do 
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/create_user'
    end
  end
  
  post '/signup' do 
    user = User.new(:username => params[:username], :password => params[:password], :email => params[:email])
    
    if user[:username].empty? || user[:password_digest] ==  nil || user[:email].empty?
    
      redirect "/signup"
    else 
     
      user.save
      session[:user_id] = user.id
      
      redirect "/tweets"
    end
  end
  
  get '/login' do 
    
  end
  
  post '/login' do 
    user = User.find_by(:username => params[:username])
    
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id 
      redirect "/succes"
    else 
      redirect "/failure"
    end
  end
  
  
  get '/logout' do 
    
  end
  
end
