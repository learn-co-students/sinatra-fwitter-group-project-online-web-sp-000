require './config/environment'

class UsersController < ApplicationController
  
  get '/users/:slug' do 
    @user = User.find_by_slug(params[:slug])
    erb :'/index'
  end 
  
   get '/login' do 
    logged_in? ? redirect('/tweets') : erb(:'/login')
  end 
  
  post '/login' do 
    user = User.find_by(username: params[:username])
    if user.authenticate(params[:password])
      log_in(user)
      redirect '/tweets'
    else
      redirect '/login'
    end 
  end 
  
  get '/logout' do 
    logged_in? ? logout : redirect('/login')
  end 
end
