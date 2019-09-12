
class UsersController < ApplicationController 

  get '/signup' do 
    erb :'/users/create_user'
  end 

  post '/signup' do
    user = User.find_by username: params[:username]
    if user == nil
      user = User.create(username: params[:username], email: params[:email], password: params[:password])    
    end
    session[:user_id] = user.id
    redirect to ('/')
  end

  get '/login' do
    @username = ""
    erb :'/users/login'
  end

  post '/login' do
    user = User.find_by username: params[:username]
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to ('/')
    else
      if user
        @username = user.username
      end
      erb :'/users/login'
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

end
