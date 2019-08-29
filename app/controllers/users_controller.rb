class UsersController < ApplicationController

  get '/signup' do
    if is_logged_in?
      redirect '/tweets'
    else
      erb :'/users/create_user'
    end
  end
  
  post '/signup' do
    @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
    if @user.save && @user.username != "" && @user.email != ""
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect '/signup'
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
    else
      redirect '/login'
    end
  end

  get '/logout' do
    if !is_logged_in?
      redirect '/users/logout'
    else
      session.clear
      redirect '/login'
    end
  end
    
  def is_logged_in?
    !!session[:user_id]
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

end
