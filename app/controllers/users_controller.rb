class UsersController < ApplicationController

  get '/signup' do 
    erb :'/create_user'
  end
  
  post '/signup' do 
    user = User.new(:username => params[:username], :password => params[:password])
    if user.save 
      redirect "/tweets"
    else 
      redirect "/signup"
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
